class FriendLinksController < ApplicationController
    before_filter :check_editor_role, :except => [:index]

  # GET /friend_links
  # GET /friend_links.json
  def index
    @friend_links = FriendLink.find_all_by_published_and_level(1,0)

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @friend_links }
    end
  end

  # GET /friend_links/1
  # GET /friend_links/1.json
  def show
    @friend_link = FriendLink.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @friend_link }
    end
  end

  # GET /friend_links/new
  # GET /friend_links/new.json
  def new
    @friend_link = FriendLink.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @friend_link }
    end
  end

  # GET /friend_links/1/edit
  def edit
    @friend_link = FriendLink.find(params[:id])
  end

  # POST /friend_links
  # POST /friend_links.json
  def create
    @friend_link = FriendLink.new(params[:friend_link])

    respond_to do |format|
      if @friend_link.save
        format.html { redirect_to @friend_link, notice: 'Friend link was successfully created.' }
        format.json { render json: @friend_link, status: :created, location: @friend_link }
      else
        format.html { render action: "new" }
        format.json { render json: @friend_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /friend_links/1
  # PUT /friend_links/1.json
  def update
    @friend_link = FriendLink.find(params[:id])

    respond_to do |format|
      if @friend_link.update_attributes(params[:friend_link])
        format.html { redirect_to @friend_link, notice: 'Friend link was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @friend_link.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /friend_links/1
  # DELETE /friend_links/1.json
  def destroy
    @friend_link = FriendLink.find(params[:id])
    @friend_link.destroy

    respond_to do |format|
      format.html { redirect_to friend_links_url }
      format.json { head :ok }
    end
  end
end
