# encoding: utf-8
class HomeController < ApplicationController
  def get_random_numbers  count
   rd = (1..count).to_a.sample(9)
  end

  def index
    @title = "首页"
    #获取前 18条娱乐相关新闻信息 含有分类名称
    #获取前 27条娱乐相关新闻信息 含有分类名称
    #@articles = Article.where(:published => true).paginate(:page => params[:page],
    #                                                :include => :user).order('published_at DESC')
    @top_articles = Article.where(:published => true).find(:all, :order => 'published_at DESC',:include => :category, :limit => 9 )
    @top_topics = Topic.find(:all, :order => 'updated_at DESC', :limit => 9 )

    #精选集
    @top_funs = Fun.find(:all, :order => 'created_at DESC', :limit => 18 )
    #时事笑话
    @top_funs_news = Fun.where(:category_id => 5).find(:all, :order => 'created_at DESC', :limit => 18 )
    #学生时代
    @top_funs_student = Fun.where(:category_id => 8).find(:all, :order => 'created_at DESC', :limit => 18 )
    #IT故事
    @top_funs_it = Fun.where(:category_id => 12).find(:all, :order => 'created_at DESC', :limit => 18 )
    #搞笑网文
    @top_funs_net = Fun.where(:category_id => 6).find(:all, :order => 'created_at DESC', :limit => 18 )
    #冷笑话
    @top_funs_cold = Fun.where(:category_id => 4).find(:all, :order => 'created_at DESC', :limit => 18 )
    #老外幽默
    @top_funs_for = Fun.where(:category_id => 11).find(:all, :order => 'created_at DESC', :limit => 18 )
    #情感趣事
    @top_funs_love = Fun.where(:category_id => 9).find(:all, :order => 'created_at DESC', :limit => 18 )

    @count = Fun.count
    #随机抽取
    @random_funs =Fun.find(get_random_numbers(@count))

    #Fun.find(:all, :order => 'click_time DESC', :limit => 9 )

    #10.times.map{ 20+Random.rand(11) }
  end

end
