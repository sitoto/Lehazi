# encoding: utf-8
module ApplicationHelper
  def title
    base_title = "乐哈子"
    if @title.nil?
      base_title
    else
      "#{@title} - #{base_title}"
    end
  end

  def custom_meta_tags
          [
            tag('meta', :name => 'title', :content => title)
          ].join("\n").html_safe
  end
end
