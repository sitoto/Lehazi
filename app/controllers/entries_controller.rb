class EntriesController < ApplicationController
    layout "we"

  before_filter :login_required, :except => [:index, :show]

  # GET /entries
  # GET /entries.json
  def index
    @user = User.find(params[:user_id])
    @entries = @user.entries.paginate(:page => params[:page], :per_page => 10).order('created_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @entries }
    end
  end

  def show
    @entry = Entry.find_by_id_and_user_id(params[:id],params[:user_id],:include => [:user, [:comments => :user]])
  end

  def new
    @entry = Entry.new
  end

  # GET /entries/1/edit
  def edit
    @entry = @current_user.entries.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end

  # POST /entries
  # POST /entries.json
  def create
    @entry = Entry.new(params[:entry])

    respond_to do |format|
      if @current_user.entries << @entry
        format.html { redirect_to  user_entries_path, notice: 'Entry was successfully created.' }
        format.json { render json: @entry, status: :created, location: @entry }
      else
        format.html { render action: "new" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /entries/1
  # PUT /entries/1.json
  def update
    @entry = @current_user.entries.find(params[:id])

    respond_to do |format|
      if @entry.update_attributes(params[:entry])
        format.html { redirect_to user_entries_path, notice: 'Entry was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /entries/1
  # DELETE /entries/1.json
  def destroy
    @entry =  @current_user.entries.find(params[:id])
    @entry.destroy

    redirect_to user_entries_path
  rescue ActiveRecord::RecordNotFound
    redirect_to :action => 'index'
  end
end
