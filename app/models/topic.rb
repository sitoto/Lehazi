#encoding: UTF-8
require 'nokogiri'
require 'open-uri'
require 'ruby-debug'

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
    init_get

    @title = doc.at_css("title").text

      doc.css(".pl20").each do |item|
        @lz = item.at_css("a").text
      end
      doc.css(".pl2").each do |item|
        @category = item.at_css("a").text.from(1)
      end
      doc.css(".topic-doc").each do |item|
        @created_at = item.at_css(".color-green").text
        item.css("p").each do |p|
          @first_post = @first_post << p.inner_html
        end

      end

      @temp={:title => @title, :username => @lz, :created_at => @created_at,
             :category => @category,:last_from_url => @url,
             :f_updated_at => @f_updated_at,
             :f_lz_updated_at => @f_lz_updated_at}
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
        @temp[:f_lz_updated_at] =  created_time
      end

      @temp[:f_updated_at] =  created_time
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
    doc = Nokogiri::HTML(open(@url))
    init_get
    @title = doc.at_css("h1").text
    @category = doc.at_css("cb").text
    #@lz = doc.at_css(".p_author_name").text

      post_json_str= doc.at_css(".l_post .p_post").attr("data-field")
			json_post = JSON.parse(post_json_str)
    @created_at = json_post["content"]["date"]
    @lz = json_post["author"]["name"]
    @temp={:title => @title, :username => @lz, :created_at => @created_at,
           :category => @category,:last_from_url => @url,
           :f_updated_at => @f_updated_at,
           :f_lz_updated_at => @f_lz_updated_at}

    filter_tieba_post doc
  end

  def filter_tieba_post doc
    doc.css(".p_postlist .l_post").each do |item|
      post_json_str = item.css(".p_post").attr("data-field")
      json_post = JSON.parse(post_json_str)

      created_at = json_post["content"]["date"]
      author = json_post["author"]["name"]
      level = json_post["content"]["floor"]
      content = gbk_changto_utf8 item.css(".d_post_content").inner_html #.force_encoding("GBK")
      #content = item.css(".d_post_content").inner_html.encode(Encoding.find("UTF-8"),Encoding.find("GBK"))

      if author == @lz
        @temp_posts[@reply_num] = [author,level,created_at, content]
        @temp[:f_lz_updated_at] =  created_at
        @reply_num += 1
      end

      @temp[:f_updated_at] =  created_at
    end

      doc.css(".p_thread .l_thread_info .l_posts_num .l_pager a").each do |link|
        if link.text == "下一页"
          href = "http://tieba.baidu.com" << link.attr("href")
          puts "next page is #{href}"
          @temp[:last_from_url] =  href
          doc = Nokogiri::HTML(open(href))
          filter_tieba_post doc
          break
        end
		  end
  end

  def chk_tieba_url
		result = ""
		regEx = /baidu\.com\/p\/[0-9]*/
		if regEx =~ @url
			result = ("http://tieba." << regEx.match(@url).to_s)
		else
			return "0"
		end
		@url = result

    if Topic.find_all_by_from_url(@url).count > 0
      return "0"
    end

    @url
  end
  #baidu-tieba -end


  #tianya--begin
  def do_get_tianya_topic
 doc = Nokogiri::HTML(open(@url))
    init_get
    @title = doc.at_css("h1 span a").parent.text
    @category = doc.at_css("h1 span a").text
    @lz = doc.at_css(".pagewrap table td a").text

		@created_at = doc.at_css(".pagewrap table td").text.last(19)
		@created_at = chk_datetime @created_at


		@tip = 0 #for get author and time
    @auth_time = {}
    @temp={:title => @title, :username => @lz, :created_at => @created_at,
           :category => @category,:last_from_url => @url,
           :f_updated_at => @f_updated_at,
           :f_lz_updated_at => @f_lz_updated_at}


    filter_tianya_post doc
  end
  def filter_tianya_post doc
    #单独获取 用户和时间 信息数组
    @first_do1 = true
    @first_do2 = true
        lz = doc.at_css(".pagewrap table td a").text
        created_at = doc.at_css(".pagewrap table td").text.last(19)
        created_at = chk_datetime created_at
        @auth_time[@tip] = [lz, created_at]
        @tip += 1

		doc.css(".allpost table").each do |item|
			author = item.at_css("center a").text
			time = chk_datetime item.at_css("center").text
			@auth_time[@tip] = [author, time]
      @tip += 1
		end

    doc.css(".allpost .post").each do |item|
      @level_num += 1
      if @first_do2 == true
        content = gbk_changto_utf8 item.inner_html #.encode(Encoding.find("UTF-8"),Encoding.find("GBK"))
        author = @auth_time[@level_num-1][0]
        created_at = @auth_time[@level_num-1][1]
        @temp_posts[@reply_num] = [author,@level_num,created_at, content]
        @reply_num += 1
        @first_do2 = false
        next
      end
      author = @auth_time[@level_num-1][0]
      created_at = @auth_time[@level_num-1][1]
      content= gbk_changto_utf8 item.inner_html #.encode(Encoding.find("UTF-8"),Encoding.find("GBK"))

      if author == @lz
        @temp_posts[@reply_num] = [author,@level_num,created_at, content]
        @temp[:f_lz_updated_at] =  created_at
        @reply_num += 1
      end

      @temp[:f_updated_at] =  created_at
    end

    doc.css("#pageDivTop a").each do |link|
			if link.text == "下一页"
				href =  link.attr("href")
				puts "next page is #{href}"
        @temp[:last_from_url] =  href
				doc = Nokogiri::HTML(open(href))
				filter_tianya_post doc
				break
			end
		end


  end


  def chk_tianya_url
   		result = ""
		regEx = /tianya\.cn\/\w*\/\w*\/([0-9]+|[a-z]*)\/[0-9]+\/[0-9]+\.shtml/
		if regEx =~ @url
			result = "http://www." << regEx.match(@url).to_s
		else
			return "0"
		end
		@url = result

    if Topic.find_all_by_from_url(@url).count > 0
      return "0"
    end

    @url
  end


  def init_get
    @title =""
		@lz = ""
    @created_at = ""
    @category = ""
    @first_post =""
    @f_updated_at = DateTime.now
    @f_lz_updated_at  = DateTime.now
    @reply_num=0
    @level_num=0
  end
	def chk_datetime str
		regEx = /2\d+-[0-9]+-[0-9]+\D[0-9]+:\d+:\d+/
		if regEx =~ str
			return regEx.match(str).to_s
		end
		return "0000"
  end

  def gbk_changto_utf8 str
	str.force_encoding("GBK")
    str.encode(Encoding.find("UTF-8"),Encoding.find("GBK"))
  end
end


