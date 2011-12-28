# encoding: utf-8
class Notifier < ActionMailer::Base
  #delivers_from "娱乐广场 <lehaxi@163.com>"
  default :from => "lehaxi@163.com"

  def welcome(recipient)
  @recipient = recipient
  mail(:to => recipient,
       :subject => "[Signed up] Welcome #{recipient}")
  end

  def new_comment_notification(comment)
    blog_owner = comment.entry.user
    recipients blog_owner.email_with_login
    from "娱乐广场 <lehaxi@163.com>"
    subject "你有新的评论"
    body  :comment => comment,
          :blog_owner => blog_owner,
          :blog_owner_url =>  "http://www.lehazi.com/users/#{blog_owner.id}",
          :blog_entry_url => "http://www.lehazi.com/users/#{blog_owner.id}/entries/#{comment.entry.id}"
  end

end
