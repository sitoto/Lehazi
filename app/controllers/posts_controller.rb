class PostsController < ApplicationController
  layout "we"
  before_filter :check_moderator_role, :only => [:destroy, :edit, :update]
  before_filter :login_required, :except => [:index, :show ]

  # GET /posts
  # GET /posts.json
  def index
    @topic =Topic.find(params[:topic_id], :include =>  :forum)
    @posts = Post.where(['topic_id = ?',@topic.id]).paginate(:page => params[:page], :include => :user)

    @topic.increment!(:click_times, by = 1)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @topic = Topic.find(params[:topic_id], :include => :forum)
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
    @post = Post.find(params[:id], :include => {:topic => :forum})
  end

  # POST /posts
  # POST /posts.json
  def create
    @topic = Topic.find(params[:topic_id])
    @post = Post.new(:body =>  params[:post][:body], :topic_id => @topic.id, :user_id => current_user.id)

    respond_to do |format|
      if @post.save
        format.html { redirect_to forum_topic_posts_path, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to forum_topic_posts_path(params[:forum_id], params[:topic_id]), notice: 'Post was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    respond_to do |format|
      format.html { redirect_to forum_topic_posts_path }
      format.json { head :ok }
    end
  end
end
