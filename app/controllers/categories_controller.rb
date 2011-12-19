class CategoriesController < ApplicationController
before_filter :check_administrator_role,:except => :show
  # GET /categories
  # GET /categories.json
  def index


    @categories = Category.all
    @htmlmenu = infoaddresstree


    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @categories }
    end

  end


  # GET /categories/1
  # GET /categories/1.json
  def show
    @category = Category.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/new
  # GET /categories/new.json
  def new
    @category = Category.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @category }
    end
  end

  # GET /categories/1/edit
  def edit
    @category = Category.find(params[:id])
  end

  # POST /categories
  # POST /categories.json
  def create
    @category = Category.new(params[:category])

    respond_to do |format|
      if @category.save
        format.html { redirect_to @category, notice: 'Category was successfully created.' }
        format.json { render json: @category, status: :created, location: @category }
      else
        format.html { render action: "new" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /categories/1
  # PUT /categories/1.json
  def update
    @category = Category.find(params[:id])

    respond_to do |format|
      if @category.update_attributes(params[:category])
        format.html { redirect_to @category, notice: 'Category was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @category.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /categories/1
  # DELETE /categories/1.json
  def destroy
    @category = Category.find(params[:id])
    @category.destroy

    respond_to do |format|
      format.html { redirect_to categories_url }
      format.json { head :ok }
    end
  end

  def admin
    @categories = Category.find(:all)
    respond_to do |format|
      format.html
      format.json { render json: @categories }
      format.xml { render xml: @categories }
    end
  end



def infoaddresstree
    @htmlmenu=""
    @htmlmenu+= "<ul>"
    @root = Category.find(:all,:conditions=>['parent_id=1'])
    @root.each { |item|
      if Category.find_by_parent_id(item.id)
      @htmlmenu+= "<li><a href='#ChildMenu#{item.id}' onclick=\"DoMenu('ChildMenu#{item.id}')\">"
      else
        @htmlmenu+= "<li><a href='/categories/#{item.id}'>"
      end
      @htmlmenu+= item.name
      @htmlmenu+= "</a>"
      buildmenu item
      @htmlmenu+= "</li>"
    }
    @htmlmenu+= "</ul>"
    @htmlmenu
end

private
  def buildmenu category
    @children = Category.find_all_by_parent_id(category.id)
    if @children.size!=0
      @htmlmenu+= "<ul id='ChildMenu#{category.id}' class='collapsed'>"
      @children.each { |item|
        if Category.find_all_by_parent_id(item.id).size!=0
          @htmlmenu+= "<li><a href='#ChildMenu#{item.id}' onclick=\"DoMenu('ChildMenu#{item.id}')\">"
        else
                @htmlmenu+= "<li><a href='/categories/#{item.id}'>"
        end

        @htmlmenu+= item.name
        @htmlmenu+= "</a>"
        buildmenu item
        @htmlmenu+= "</li>"
        }
      @htmlmenu+= "</ul>"

    end
end

end
