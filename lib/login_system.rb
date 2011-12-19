module LoginSystem
  protected

  def check_role(role)
    unless is_logged_in? && @logged_in_user.has_role?(role)
      flash[:error] = "You don't have the permission to do that.'"
      redirect_to login_url
    end
    def check_administrator_role
      check_role('Administrator')
    end
  end
end
