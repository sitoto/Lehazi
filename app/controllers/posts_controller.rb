#encoding: utf-8
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
    @last_topic_post = Post.find_by_sql("Select * from posts where topic_id=#{params[:topic_id]} order by id desc limit 1")
    #("topic_id" => params[:topic_id], :limit => 1).order( 'posts.id DESC')

    #获取本站 最新的post、获取本主题最后 更新网址、总帖数
    #@post = Post.new(:body =>  params[:post][:body], :topic_id => @topic.id, :user_id => current_user.id)
    @post = Post.new()
    @post.init_url_type(@topic.forum_id, @topic.f_username, @last_topic_post[0].f_level_num, @topic.last_from_url, @topic.f_updated_at)

    @ttt = @post.get_new_topic

    if @ttt[:update_num] == -1
      if @ttt[:f_updated_at] !=  @topic.f_updated_at
        @topic.update_attribute("f_updated_at", @ttt[:f_updated_at])
        @topic.save
        redirect_to forum_topic_posts_path(@topic.forum, @topic), :notice => t('update_post_info1')
        return
      end
      # there is not new post
      redirect_to forum_topic_posts_path(@topic.forum, @topic), :notice => t('update_post_info2')
      return
    end

    #there is some new post update the topic
    @topic.update_attributes(:last_from_url => @ttt[:last_from_url], :f_updated_at => @ttt[:f_updated_at],
                              :f_lz_updated_at => @ttt[:f_lz_updated_at])
    @topic.save!
    #add the new posts
    @post.get_all_posts.each do |key,value|
      @post = Post.new(:body => value[3],:created_at => value[2],:f_level_num => value[1], :topic_id => @topic.id, :user_id => current_user.id)
      @post.save!
    end



    respond_to do |format|
        format.html { redirect_to forum_topic_posts_path, notice: "更新完成.增加了#{@ttt[:update_num]}条楼主贴子" }
        format.json { render json: @post, status: :created, location: @post }
    end

    rescue ActiveRecord::RecordInvalid
      respond_to do |format|
        format.html { render action: "new" }
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
