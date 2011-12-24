class FunsController < ApplicationController
  before_filter :check_editor_role, :except => [:index, :show]

  # GET /funs
  # GET /funs.json
  def index

    if params[:category_id]
       @funs = Fun.where("category_id=#{params[:category_id].to_i}").paginate(:page => params[:page],
                                                    :include => :user).order ( 'created_at DESC')
    else
      @funs = Fun.paginate(:page => params[:page], :include => :user).order('created_at DESC')
    end
    @funs.each do |f|
        f.increment!(:click_time, by = 1)
    end

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @funs }
    end
  end

  # GET /funs/1
  # GET /funs/1.json
  def show
      @fun =Fun.find(params[:id])
      @fun.increment!(:click_time, by = 1)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @fun }
    end
  end

  # GET /funs/new
  # GET /funs/new.json
  def new
    @fun = Fun.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @fun }
    end
  end

  # GET /funs/1/edit
  def edit
    @fun = Fun.find(params[:id])
  end

  # POST /funs
  # POST /funs.json
  def create
    @fun = Fun.new(params[:fun])
    @current_user.funs << @fun
    respond_to do |format|
      if @fun.save
        format.html { redirect_to @fun, notice: 'Fun was successfully created.' }
        format.json { render json: @fun, status: :created, location: @fun }
      else
        format.html { render action: "new" }
        format.json { render json: @fun.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /funs/1
  # PUT /funs/1.json
  def update
    @fun = Fun.find(params[:id])

    respond_to do |format|
      if @fun.update_attributes(params[:fun])
        format.html { redirect_to @fun, notice: 'Fun was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @fun.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /funs/1
  # DELETE /funs/1.json
  def destroy
    @fun = Fun.find(params[:id])
    @fun.destroy

    respond_to do |format|
      format.html { redirect_to funs_url }
      format.json { head :ok }
    end
  end
  def admin
     @funs = Fun.paginate(:page => params[:page], :include => :user).order('created_at DESC')
  end
end
