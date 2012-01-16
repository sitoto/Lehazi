# encoding: utf-8
class WeController < ApplicationController
  def index
    @title = "乐哈社区"
    redirect_to forums_url

  end
  def tieba
    @title = "贴吧热贴"

    redirect_to forum_topics_url("1-tieba")
  end
  def tianya
    @title = "天涯热贴"
    redirect_to forum_topics_url("2-tianya")

  end
  def douban
    @title = "豆瓣直播"
    redirect_to forum_topics_url("3-douban")
  end

end
