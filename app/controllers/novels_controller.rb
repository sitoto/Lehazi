class NovelsController < ApplicationController
  before_filter :check_editor_role, :except => [:index, :show]

  # GET /novels
  # GET /novels.json
  def index
    @novels = Novel.paginate(:page => params[:page]).order('created_at DESC')
  end

  # GET /novels/1
  # GET /novels/1.json
  def show
    @novel = Novel.find(params[:id])
  end

  # GET /novels/new
  # GET /novels/new.json
  def new
    @novel = Novel.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @novel }
    end
  end

  # GET /novels/1/edit
  def edit
    @novel = Novel.find(params[:id])
  end

  # POST /novels
  # POST /novels.json
  def create
    @novel = Novel.new(params[:novel])

    respond_to do |format|
      if @novel.save
        format.html { redirect_to @novel, notice: 'Novel was successfully created.' }
        format.json { render json: @novel, status: :created, location: @novel }
      else
        format.html { render action: "new" }
        format.json { render json: @novel.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /novels/1
  # PUT /novels/1.json
  def update
    @novel = Novel.find(params[:id])

    respond_to do |format|
      if @novel.update_attributes(params[:novel])
        format.html { redirect_to @novel, notice: 'Novel was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @novel.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /novels/1
  # DELETE /novels/1.json
  def destroy
    @novel = Novel.find(params[:id])
    @novel.destroy

    respond_to do |format|
      format.html { redirect_to novels_url }
      format.json { head :ok }
    end
  end

  def admin
    @novels = Novel.paginate(:page => params[:page]).order('created_at DESC')
  end
end
