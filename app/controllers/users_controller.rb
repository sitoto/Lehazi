# encoding: utf-8
class UsersController < ApplicationController
  before_filter :check_administrator_role,
      :only => [:index,:destroy,:enable]
  before_filter :login_required, :only => [:edit, :update]

  def index
    @users =User.find(:all)
  end
  def show
    @user = User.find(params[:id])
    @entries = @user.entries.find(:all, :limit => 3, :order => 'created_at DESC')
  end
  def show_by_name
    @user= User.find_by_username(params[:login])
    render :action => 'show'
  end


 def new
    @user = User.new
  end

  def create
    @user = User.new(params[:user])
    @user.current_login_ip=request.remote_ip
    if @user.save
      redirect_to root_url, :notice => "Signed up!"
    else
      render "new"
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = User.find(current_user)
    if @user.update_attributes(params[:user])
      flash[:notice] = "修改成功"
      redirect_to current_user
    else
      render :action => 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled,false)
      flash[:notice] = "用户被禁用。"
    else
      flash[:error] = "禁用出错。"
    end
    redirect_to :action => 'index'
  end

  def enable
    @user = User.find(params[:id])
    if @user.update_attribute(:enabled,true)
      flash[:notice] = "用户启用。"
    else
      flash[:error] = "用户启用出错。"
    end
    redirect_to :action => 'index'
  end
end
