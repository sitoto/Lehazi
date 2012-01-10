# encoding: utf-8
class GamesController < ApplicationController
  before_filter :check_editor_role, :except => [:index, :show]

  def index
    if params[:category_id]
       @games = Game.where("category_id=#{params[:category_id].to_i}").paginate(:page => params[:page], :per_page => 30).order ( 'hot_num DESC')
    else
      @games = Game.paginate(:page => params[:page],:per_page => 30).order('hot_num DESC')
    end
    @games.each do |f|
        f.increment!(:hot_num, by = 1)
    end

    @title = '什么游戏好玩'
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @games }
    end
  end

  # GET /games/1
  # GET /games/1.json
  def show
    @game = Game.find(params[:id].to_i)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/new
  # GET /games/new.json
  def new
    @game = Game.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @game }
    end
  end

  # GET /games/1/edit
  def edit
    @game = Game.find(params[:id].to_i)
  end

  # POST /games
  # POST /games.json
  def create
    @game = Game.new(params[:game])

    respond_to do |format|
      if @game.save
        format.html { redirect_to @game, notice: 'Game was successfully created.' }
        format.json { render json: @game, status: :created, location: @game }
      else
        format.html { render action: "new" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /games/1
  # PUT /games/1.json
  def update
    @game = Game.find(params[:id].to_i)

    respond_to do |format|
      if @game.update_attributes(params[:game])
        format.html { redirect_to @game, notice: 'Game was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @game.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /games/1
  # DELETE /games/1.json
  def destroy
    @game = Game.find(params[:id].to_i)
    @game.destroy

    respond_to do |format|
      format.html { redirect_to games_url }
      format.json { head :ok }
    end
  end
    def admin
     @games = Game.paginate(:page => params[:page]).order('hot_num DESC')
  end
end
