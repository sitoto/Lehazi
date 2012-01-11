#encoding: utf-8
class TopicsController < ApplicationController
  layout "we"

  before_filter :check_moderator_role, :only => [:destroy, :edit, :update]
  before_filter :login_required, :except => [:index, :show, :last, :newtopic ]

  # GET /topics
  # GET /topics.json
  def index
    @forum = Forum.find(params[:forum_id])
    @topics = Topic.where("forum_id=#{params[:forum_id].to_i} ").paginate(:page => params[:page],
                                                    :include => :user).order ( 'topics.posts_count DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @topics }
    end
  end

  # GET /topics/1
  # GET /topics/1.json
  def show
    redirect_to forum_topic_posts_path(params[:forum_id],params[:id])
  end

  # GET /topics/new
  # GET /topics/new.json
  def new
    @topic = Topic.new
    @post = Post.new
  end

  # GET /topics/1/edit
  def edit
    @topic = Topic.find(params[:id])
  end

  # POST /topics
  # POST /topics.json
  def create
    #获取-提交的信息
    @topic = Topic.new(:name => 'temp',:from_url => params[:topic][:from_url],
                        :forum_id => params[:forum_id].to_i, :user_id => current_user.id)

    #获取 主题、楼主、创建时间、
    @topic.init_url_type(@topic.from_url, @topic.forum_id)

    @ttt = @topic.get_new_topic

    if @ttt  == nil

      redirect_to new_forum_topic_path(@topic.forum_id), :notice => "错误，无法采集，可能该贴已存在！"
=begin
      respond_to do |format|
        format.html { render action: "new" }
      end
=end
      return
    end


    @topic.update_attribute("name", @ttt[:title])
    @topic.update_attribute("created_at", @ttt[:created_at])
    @topic.update_attribute("f_username", @ttt[:username])
    @topic.update_attribute("f_category", @ttt[:category].from(1))
    @topic.save!

    @topic.get_all_posts.each do |key,value|
      @post = Post.new(:body => value[3],:created_at => value[2],:f_level_num => value[1], :topic_id => @topic.id, :user_id => current_user.id)
      @post.save!
    end



    respond_to do |format|
        format.html { redirect_to forum_topic_posts_path(@topic.forum_id,@topic.id), notice: 'Topic was successfully created.' }
        #format.json { render json: @topic, status: :created, location: @topic }
    end

  rescue ActiveRecord::RecordInvalid
    respond_to do |format|
      format.html { render action: "new" }
      format.json { render json: @topic.errors, status: :unprocessable_entity }

    end

  end

  # PUT /topics/1
  # PUT /topics/1.json
  def update
    @topic = Topic.find(params[:id])

    respond_to do |format|
      if @topic.update_attributes(params[:topic])
        format.html { redirect_to forum_topics_path, notice: 'Topic was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @topic.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /topics/1
  # DELETE /topics/1.json
  def destroy
    @topic = Topic.find(params[:id])
    @topic.posts.each {|post| post.destroy }
    @topic.destroy

    respond_to do |format|
      format.html { redirect_to forum_topics_path }
      format.json { head :ok }
    end
  end

  def newtopic
    @forum = Forum.find(params[:forum_id])
    @topics = Topic.where("forum_id=#{params[:forum_id].to_i} ").paginate(:page => params[:page],
                                                    :include => :user).order ( 'topics.created_at DESC')

  end
    def last
    @forum = Forum.find(params[:forum_id])
    @topics = Topic.where("forum_id=#{params[:forum_id].to_i} ").paginate(:page => params[:page],
                                                    :include => :user).order ( 'topics.updated_at DESC')

  end
end
