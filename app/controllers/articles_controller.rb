class ArticlesController < ApplicationController
  before_filter :check_editor_role, :except => [:index, :show]

  def index
    @articles
    if params[:category_id]
       @articles = Article.where("category_id=#{params[:category_id].to_i} AND published=true").paginate(:articles,
                                                    :include => :user).order ( 'published_at DESC')
    else
      @articles = Article.where(:published => true).paginate(:page => params[:page],
                                                    :include => :user).order('published_at DESC')
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
