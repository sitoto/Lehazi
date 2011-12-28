class BlogController < ApplicationController
  def index
    @entries = Entry.paginate(:page => params[:page],:include => :user).order('created_at DESC')
  end

end
