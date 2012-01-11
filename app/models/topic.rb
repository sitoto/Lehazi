require 'nokogiri'
require 'open-uri'

class Topic < ActiveRecord::Base
  belongs_to :forum, :counter_cache => true
  belongs_to :user
  has_many :posts, :dependent => :delete_all

  validates_presence_of :name
  validates_length_of :name, :maximum => 255

  #common
    def init_url_type(u , t)
      @url = u
      @type = t
    end

    def get_new_topic
      @temp
      @temp_posts ={}
      get_base_info
      @temp
    end

    def get_all_posts
      @temp_posts
    end


    def get_base_info
      if @type == 1
        chk_tieba_url != "0" ? do_get_tieba_topic : ""
      else if @type == 2
              chk_tianya_url != "0" ? do_get_tianya_topic : ""
          else if @type == 3
                  chk_douban_url != "0" ? do_get_douban_topic : ""
                end
        end
      end
    end
 #common- end


  #www.douban.com
  def do_get_douban_topic
    doc = Nokogiri::HTML(open(@url))
		@title = doc.at_css("title").text
		@lz = ""
    @created_at = ""
    @category = ""
    @first_post =""


    @reply_num=0
    @level_num=0

      doc.css(".pl20").each do |item|
        @lz = item.at_css("a").text
      end
      doc.css(".pl2").each do |item|
        @category = item.at_css("a").text
      end
      doc.css(".topic-doc").each do |item|
        @created_at = item.at_css(".color-green").text
        @first_post = item.at_css("p").inner_html
      end

      @temp={:title => @title, :username => @lz, :created_at => @created_at,
             :category => @category,:last_from_url => @url}
      #Get Posts
      @temp_posts[0] =[@lz,0,@created_at,@first_post]
      filter_douban_post doc
  end

  def filter_douban_post doc
    doc.css(".reply-doc").each do |item|
			@level_num += 1
			author = item.at_css("a").text
      created_time  = item.at_css("h4").text
			content= item.at_css("p").inner_html
      if author == @lz
        @reply_num += 1
        @temp_posts[@reply_num] = [author,@level_num,created_time, content]
      end
    end

    doc.css(".next a").each do |link|
      if link.attr("href")
         href = link.attr("href")
         @temp[:last_from_url] =  href
         doc = Nokogiri::HTML(open(href))
         filter_douban_post doc
      end
    end
  end

	def chk_douban_url
		result = ""
		regEx = /douban\.com\/group\/topic\/[0-9]*/
		if regEx =~ @url
			result = ("http://www." << regEx.match(@url).to_s << "/")
		else
			return "0"
		end
		@url = result

    if Topic.find_all_by_from_url(@url).count > 0
      return "0"
    end

    @url
  end
 #www.douban.com  -end

 #baidu -tieba
  def do_get_tieba_topic
  end
  def do_get_tianya_topic
  end

  def chk_tieba_url
    "0"
  end
  def chk_tianya_url
    "0"
  end
end
