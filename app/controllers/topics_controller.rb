class TopicsController < ApplicationController
  layout "we"

  before_filter :check_moderator_role, :only => [:destroy, :edit, :update]
  before_filter :login_required, :except => [:index, :show, :last, :newtopic ]

  # GET /topics
  # GET /topics.json
  def index
    @forum = Forum.find(params[:forum_id])
    @topics = Topic.where("forum_id=#{params[:forum_id].to_i} ").paginate(:page => params[:page],
                                                    :include => :user).order ( 'topics.click_times DESC')

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
    @topic = Topic.new(:name => params[:topic][:name], :forum_id => params[:forum_id], :user_id => current_user.id)
    @topic.save!
    @post = Post.new(:body => params[:post][:body],:topic_id => @topic.id, :user_id => current_user.id)
    @post.save!


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
