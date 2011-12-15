class RentInfosController < ApplicationController
  # GET /rent_infos
  # GET /rent_infos.json
  def index
    @rent_infos = RentInfo.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rent_infos }
    end
  end

  # GET /rent_infos/1
  # GET /rent_infos/1.json
  def show
    @rent_info = RentInfo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rent_info }
    end
  end

  # GET /rent_infos/new
  # GET /rent_infos/new.json
  def new
    @rent_info = RentInfo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rent_info }
    end
  end

  # GET /rent_infos/1/edit
  def edit
    @rent_info = RentInfo.find(params[:id])
  end

  # POST /rent_infos
  # POST /rent_infos.json
  def create
    @rent_info = RentInfo.new(params[:rent_info])

    respond_to do |format|
      if @rent_info.save
        format.html { redirect_to @rent_info, notice: 'Rent info was successfully created.' }
        format.json { render json: @rent_info, status: :created, location: @rent_info }
      else
        format.html { render action: "new" }
        format.json { render json: @rent_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rent_infos/1
  # PUT /rent_infos/1.json
  def update
    @rent_info = RentInfo.find(params[:id])

    respond_to do |format|
      if @rent_info.update_attributes(params[:rent_info])
        format.html { redirect_to @rent_info, notice: 'Rent info was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @rent_info.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rent_infos/1
  # DELETE /rent_infos/1.json
  def destroy
    @rent_info = RentInfo.find(params[:id])
    @rent_info.destroy

    respond_to do |format|
      format.html { redirect_to rent_infos_url }
      format.json { head :ok }
    end
  end
end
