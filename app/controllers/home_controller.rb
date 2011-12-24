class HomeController < ApplicationController
  def index
    #获取前 18条娱乐相关新闻信息 含有分类名称
    #获取前 27条娱乐相关新闻信息 含有分类名称
    #@articles = Article.where(:published => true).paginate(:page => params[:page],
    #                                                :include => :user).order('published_at DESC')
    @top_articles = Article.where(:published => true).find(:all, :order => 'published_at DESC',:include => :category, :limit => 18 )
    @top_funs = Fun.find(:all, :order => 'created_at DESC', :limit => 27 )
    @random_funs = Fun.find(:all, :order => 'click_time DESC', :limit => 9 )

    #10.times.map{ 20+Random.rand(11) }
  end

end
