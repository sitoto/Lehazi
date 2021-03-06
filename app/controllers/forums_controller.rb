#encoding: UTF-8
class ForumsController < ApplicationController
    layout "we"
  before_filter :check_moderator_role, :except => [:index, :show]

  # GET /forums
  # GET /forums.json
  def index
    @forums = Forum.all
    @title = "乐贴"
    @keywords = "只看楼主,乐一下,了一下,leyixia,乐哈网,乐哈子,热贴,热吧,热区,豆瓣直播,贴吧,天涯,直播,脱水"
    @description = "乐哈网，热贴热吧，娱乐信息"

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @forums }
    end
  end

  # GET /forums/1
  # GET /forums/1.json
  def show
    redirect_to forum_topics_url(params[:id].to_i)
  end

  # GET /forums/new
  # GET /forums/new.json
  def new
    @forum = Forum.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @forum }
    end
  end

  # GET /forums/1/edit
  def edit
    @forum = Forum.find(params[:id].to_i)
  end

  # POST /forums
  # POST /forums.json
  def create
    @forum = Forum.new(params[:forum])

    respond_to do |format|
      if @forum.save
        format.html { redirect_to forums_path, notice: 'Forum was successfully created.' }
        format.json { render json: @forum, status: :created, location: @forum }
      else
        format.html { render action: "new" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /forums/1
  # PUT /forums/1.json
  def update
    @forum = Forum.find(params[:id].to_i)

    respond_to do |format|
      if @forum.update_attributes(params[:forum])
        format.html { redirect_to @forum, notice: 'Forum was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @forum.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /forums/1
  # DELETE /forums/1.json
  def destroy
    @forum = Forum.find(params[:id].to_i)
    @forum.destroy

    respond_to do |format|
      format.html { redirect_to forums_url }
      format.json { head :ok }
    end
  end
end
