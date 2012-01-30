# encoding: utf-8
module ApplicationHelper
  include TagsHelper

  def title
    base_title = "乐哈子 乐哈网"
    if @title.nil?
      base_title
    else
      "#{@title} - #{base_title}"
    end
  end

  def keywords
    base_keywords = "幽默,笑话,乐一下"
    if @keywords.nil?
      base_keywords
    else
      "#{@keywords}"
    end
  end  
  def description
    base_description = ""
    if @description.nil?
      base_description
    else
      "#{@description}"
    end
  end

  def custom_meta_tags
          [
            tag('meta', :name => 'title', :content => title),
            tag('meta', :name => 'keywords', :content => keywords),
            tag('meta', :name => 'description', :content => description)
          ].join("\n").html_safe
  end
  
  def link_back
    link_to "<- Go Back", request.env["HTTP_REFERER"].blank? ? "/" : request.env["HTTP_REFERER"]
  end

end
