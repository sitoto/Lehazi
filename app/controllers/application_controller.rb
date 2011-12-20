# encoding: utf-8
class ApplicationController < ActionController::Base
 protect_from_forgery
  helper_method :current_user

  #before_filter :authorize
  private

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def is_logged_in?
    login,password = get_http_auth_data
    @current_user = User.find(session[:user_id]) if session[:user_id]
    @current_user = User.authenticate(login,password) if login && password
    @current_user ? @current_user : false
  end

  protected

  def authorize
    unless User.find_by_id(session[:user_id])
      redirect_to login_url
    end
  end

  def check_role(role)
    unless is_logged_in? && current_user.has_roles?(role)
      respond_to do|format|
        format.html do
          flash[:error] = "You don't have the permission to do that.'"
          redirect_to login_url
        end
        format.xml do
          headers["Status"]           = "Unauthorized"
          headers["WWW-Authenticate"] = %(Basic realm="Web Password")
          render :text => "Could't authenticate you",
                 :status => '401 Unauthorized',
                 :layout => false
        end
      end

    end
  end

  def check_editor_role
    check_role('Editor')
  end

  def check_administrator_role
      check_role('Administrator')
  end

  def login_required
    unless is_logged_in?
      respond_to do |format|
        format.html do
          flash[:error] = "请先登录。"
          redirect_to login_url
        end
        format.xml do
          headers["Status"]           = "Unauthorized"
          headers["WWW-Authenticate"] = %(Basic realm="Web Password")
          render :text => "Could't authenticate you",
                 :status => '401 Unauthorized',
                 :layout => false
        end
      end

    end
  end

  private
  def get_http_auth_data
    login, password = nil, nil
    auth_headers = ['X-HTTP_AUTHORIZATION', 'Authorization', 'HTTP_AUTHORIZATION',
      'REDIRECT_REDIRECT_X_http_AUTHORIZATION']
    auth_header = auth_headers.detect { |key| request.env[key] }
    auth_data = request.env[auth_header].to_s.split

    if auth_data && auth_data[0] == 'Basic'
      login, password = Base64.decode64(auth_data[1]).split(':')[0..1]
    end
    return [login, password]
  end

end
