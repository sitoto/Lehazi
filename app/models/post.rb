#encoding: UTF-8
#require 'nokogiri'
require 'open-uri'
require 'ruby-debug'

class Post < ActiveRecord::Base
  belongs_to :topic, :counter_cache => true
  belongs_to :user, :counter_cache => true

  validates_presence_of :body
  validates_length_of :body, :maximum => 10000

  def init_url_type topic_id, f_username,f_level_num, last_from_url, f_updated_at
    #debugger
    @level_num = f_level_num
    @lz = f_username
    @f_updated_at = f_updated_at
    @temp_posts = {}
    @auth_time = {}
    @reply_num = -1
    @tip = 0
    @level_tip = 0
    @temp = {:update_num => @reply_num, :username => @lz, :last_from_url => last_from_url,
             :f_updated_at => @f_updated_at,
             :f_lz_updated_at => @f_lz_updated_at}

     check_type topic_id,last_from_url
  end

  def check_type topic_id ,last_from_url
    doc = Nokogiri::HTML(open(last_from_url))
    if topic_id == 1
      filter_tieba_post doc
    end
    if topic_id == 2
      filter_tianya_post doc
    end

    if topic_id == 3
      filter_douban_post doc
    end

  end


  def get_all_posts
    @temp_posts
  end

  def get_new_topic
    @temp
  end

  def filter_tieba_post doc
    doc.css(".p_postlist .l_post").each do |item|
      post_json_str = item.css(".p_post").attr("data-field")
      json_post = JSON.parse(post_json_str)

      created_at = json_post["content"]["date"]
      if @reply_num == -1
           if @f_updated_at.to_datetime.to_s(:number)  == created_at.to_datetime.to_s(:number)
             @reply_num = 0
           end
        next
      end

      author = json_post["author"]["name"]
      level = json_post["content"]["floor"]
      content = gbk_changto_utf8 item.css(".d_post_content").inner_html #.encode(Encoding.find("UTF-8"),Encoding.find("GBK"))


      if author == @lz
        @temp_posts[@reply_num] = [author,level,created_at, content]
        @temp[:f_lz_updated_at] =  created_at
        @reply_num += 1
        @temp[:update_num] = @reply_num
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

  def filter_tianya_post doc
    #单独获取 用户和时间 信息数组

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
      puts @tip
      @tip += 1

		end

    doc.css(".allpost .post").each do |item|
      @level_tip += 1
      @level_num += 1
      if @first_do2 == true
        @first_do2 = false
        content = gbk_changto_utf8 item.inner_html #.encode(Encoding.find("UTF-8"),Encoding.find("GBK"))
        author = @auth_time[@level_tip-1][0]
        created_at = @auth_time[@level_tip-1][1]

        if @reply_num == -1
           if @f_updated_at.to_datetime.to_s(:number)  == created_at.to_datetime.to_s(:number)
             @reply_num = 0

           end
          next
        end
        @temp_posts[@reply_num] = [author,@level_num,created_at, content]
        @reply_num += 1

        next
      end

      author = @auth_time[@level_tip-1][0]
      created_at = @auth_time[@level_tip-1][1]
      content= gbk_changto_utf8 item.inner_html #.encode(Encoding.find("UTF-8"),Encoding.find("GBK"))


      if @reply_num == -1
           if @f_updated_at.to_datetime.to_s(:number)  == created_at.to_datetime.to_s(:number)
             @reply_num = 0
           end
        next
      end

      #debugger
      if author == @lz
        puts "lz == author"
        #debugger
        @temp_posts[@reply_num] = [author,@level_num,created_at, content]
        @temp[:f_lz_updated_at] =  created_at
        @reply_num += 1
        @temp[:update_num] = @reply_num
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


  def filter_douban_post doc

    doc.css(".reply-doc").each do |item|
      author = item.at_css("a").text
      created_at  = item.at_css("h4").text
      content= item.at_css("p").inner_html
      #is begin?
      #debugger
      if @reply_num == -1
           if @f_updated_at.to_datetime.to_s(:number)  == created_at.to_datetime.to_s(:number)
             @reply_num = 0
           end
        next
      end
      #debugger
      #begin to get posts
      @level_num += 1
      if author == @lz
        @temp_posts[@reply_num] = [author,@level_num,created_at, content]
        @reply_num += 1;
        @temp[:update_num] = @reply_num
        @temp[:f_lz_updated_at] =  created_at


      end

      @temp[:f_updated_at] = created_at
    end

    doc.css(".next a").each do |link|
      if link.attr("href")
         href = link.attr("href")
         puts "next page is #{href}"
         @temp[:last_from_url] =  href
         doc = Nokogiri::HTML(open(href))
         filter_douban_post doc
      end
    end
  end


 	def chk_datetime str
		regEx = /2\d+-[0-9]+-[0-9]+\D[0-9]+:\d+:\d+/
		if regEx =~ str
			return regEx.match(str).to_s
		end
		return "0000"
  end
  
  def gbk_changto_utf8 str
	str.force_encoding('GBK')
	str.encode('UTF-8', :invalid => :replace, :undef => :replace, :replace => '?').force_encoding('UTF-8')
	#str.encode('UTF-8')
    #str.encode(Encoding.find("UTF-8"),Encoding.find("GBK"))
  end

end
