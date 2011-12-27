module EntriesHelper
  def blog_title(user)
    user.blog_title ||= user.login
  end
end
