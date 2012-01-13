require 'nokogiri'
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
    @reply_num = -1
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

  end

  def filter_tianya_post doc

  end



  def filter_douban_post doc

    doc.css(".reply-doc").each do |item|
      author = item.at_css("a").text
      created_time  = item.at_css("h4").text
      content= item.at_css("p").inner_html
      #is begin?
      #debugger
      if @reply_num == -1
           if @f_updated_at.to_datetime.to_s(:number)  == created_time.to_datetime.to_s(:number)
             @reply_num = 0
           end
        next
      end
      #debugger
      #begin to get posts
      @level_num += 1
      if author == @lz
        @temp_posts[@reply_num] = [author,@level_num,created_time, content]
        @reply_num += 1;
        @temp[:update_num] = @reply_num
        @temp[:f_lz_updated_at] =  created_time


      end

      @temp[:f_updated_at] = created_time
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




end
