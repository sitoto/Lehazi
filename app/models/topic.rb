require 'nokogiri'
require 'open-uri'

class Topic < ActiveRecord::Base
  belongs_to :forum, :counter_cache => true
  belongs_to :user
  has_many :posts, :dependent => :delete_all

  validates_presence_of :name
  validates_length_of :name, :maximum => 255

  attr_accessor :pages

    def init_url_type(u , t)
      @url = u
      @type = t
    end

    def get_new_topic
=begin
      chk_douban_url
      doc = Nokogiri::HTML(open(@url))
      @title = doc.at_css("title").text
=end

      @temp
      @temp_posts ={}
      get_base_info
      @temp

    end

    def get_all_posts
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

  #do_get_tieba_topic
  def do_get_tieba_topic
  end
  def do_get_tianya_topic
  end

  #www.douban.com
  def do_get_douban_topic
    doc = Nokogiri::HTML(open(@url))
		@title = doc.at_css("title").text
		@lz = ""
    @created_at = ""
    @category = ""
		@pages = 0

      doc.css(".pl20").each do |item|
        @lz = item.at_css("a").text
      end
      doc.css(".pl2").each do |item|
        @category = item.at_css("a").text
      end
      doc.css(".topic-doc").each do |item|
        @created_at = item.at_css(".color-green").text
      end

      @temp={:title => @title, :username => @lz, :created_at => @created_at, :category => @category}

      @reply_num=0
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

  end
  def chk_tieba_url
    "0"
  end
  def chk_tianya_url
    "0"
  end
end
