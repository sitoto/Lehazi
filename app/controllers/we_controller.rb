# encoding: utf-8
class WeController < ApplicationController
  def index
    @title = "乐哈社区"
  end
  def tieba
    @title = "贴吧热贴"
  end
  def tianya
    @title = "天涯热贴"
  end
  def douban
    @title = "豆瓣直播"
  end
end
