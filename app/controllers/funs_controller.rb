# encoding: utf-8
class FunsController < ApplicationController
  include TagsHelper

  before_filter :check_editor_role, :except => [:index, :show]

  # GET /funs
  # GET /funs.json
  def index

    if params[:category_id]
       @funs = Fun.where("category_id=#{params[:category_id].to_i}").paginate(:page => params[:page], :per_page => 10,
                                                    :include => :user).order ( 'created_at DESC')
       @fun_category = Category.find(params[:category_id])
    else
      @funs = Fun.paginate(:page => params[:page],:per_page => 10, :include => :user).order('created_at DESC')
    end
    @funs.each do |f|
        f.increment!(:click_time, by = 1)
    end

    @title = '幽默短文'
    @keywords = '故事,笑话,网文,小笑话,幽默短片,xiaohua,xiaoshuo,gaoxiao,好笑,乐一下,了下,乐哈,leha,'
    @description = "搞笑网文、幽默笑话、时事笑话集散地"
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @funs }
    end
  end

  # GET /funs/1
  # GET /funs/1.json
  def show
      a = Integer(params[:id]) -1
      b = Integer(params[:id]) +1
      @fun =Fun.find(params[:id])
      Fun.exists?(a) ?  @fun_p =Fun.find_by_sql("select id, title from funs where id = #{a}") : @fun_p =nil
      Fun.exists?(b) ?  @fun_n =Fun.find_by_sql("select id, title from funs where id = #{b}") : @fun_n =nil

      @fun.increment!(:click_time, by = 1)
      @title = @fun.title  + ' - ' + @fun.category.name
      @keywords = tag_get("fun", @fun.id, 20)
      @description = @fun.body.truncate(255)

      arr = get_random_numbers(Fun.count,18)

      #@relation_funs = Fun.find_by_sql("select id, title, click_time from funs where category_id =#{@fun.category_id} and id in #{arr} order by click_time DESC ")
      @relation_funs = Fun.find(arr)
      respond_to do |format|
        format.html # show.html.erb
        format.json { render json: @fun }
      end
  rescue
    redirect_to funs_path, :notice => "未知的参数"
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

  def get_random_numbers  count,max
   (1..count).to_a.sample(max)
  end
end
