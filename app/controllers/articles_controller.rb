# encoding: utf-8
class ArticlesController < ApplicationController
  include TagsHelper

  before_filter :check_editor_role, :except => [:index, :show]

  def index
    @title = "娱乐信息"
    @keywords = '网文,小笑话,好笑,乐一下,了下,乐哈,gaoxiao,leha'
    @description = "娱乐新闻、搞笑网文、weibo笑话、微博趣事、围脖搞笑、八卦、明星"

    if params[:category_id]
       @articles = Article.where("category_id=#{params[:category_id].to_i} AND published=true").paginate(:page => params[:page],
                                                    :include => :user).order ( 'published_at DESC')
       @article_category = Category.find(params[:category_id])
    else
       if params[:tag_id]
         @tag_name = Tag.find(params[:tag_id]).name
          @title <<"_" <<  @tag_name
          @keywords = @tag_name
         @articles = Article.where( "taggings.tag_id = #{params[:tag_id].to_i} and taggings.taggable_type = 'article'").joins(" right join taggings on articles.id = taggable_id").paginate(:page => params[:page], :per_page => 10,
                                                    :include => :user,  :readonly => false).order ( 'articles.published_at DESC')
       else
      @articles = Article.where(:published => true).paginate(:page => params[:page],
                                                    :include => :user).order('published_at DESC')
       end

    end

    respond_to do |format|
      format.html # index.html.erb
      format.xml {render :xml =>@articles.to_xml }
      format.rss {render :action => 'rss.rxml',:layout => false }
      format.atom {render :action => 'atom.rxml',:layout => false }
    end
  end

  def show
    if is_logged_in? && @current_user.has_roles?('Editor')
      @article =Article.find(params[:id])
    else
      @article = Article.find_by_id_and_published(params[:id], true)
    end

    @title = @article.title  + '_' + @article.category.name
    @keywords = tag_get("article", @article.id, 20)
    @description = @article.synopsis.truncate(255)

    respond_to do |format|
      format.html
      format.xml { render :xml => @article.to_xml }
    end
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.create(params[:article])
    @current_user.articles << @article
    respond_to do |format|
      format.html { redirect_to admin_articles_url }
      format.xml  { render :xml => @article.to_xml }
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(params[:article])
    respond_to do |format|
      format.html {redirect_to admin_articles_url}
      format.xml  {render :xml => @article.to_xml }
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    respond_to do |format|
      format.html {redirect_to admin_articles_url}
      format.xml  {render :nothing => true }
    end
  end

  def admin
     @articles = Article.paginate(:page => params[:page],
                                                    :include => :user).order('published_at DESC')
  end

end
