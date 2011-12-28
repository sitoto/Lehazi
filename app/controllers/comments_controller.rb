class CommentsController < ApplicationController
  before_filter :login_required
  # POST /comments
  # POST /comments.json
  def create
    @entry  = Entry.find_by_user_id_and_id(params[:user_id],params[:entry_id])
    @comment = Comment.new(:user_id => current_user.id, :body => params[:comment][:body])

    respond_to do |format|
      if @entry.comments << @comment
        Notifier.new_comment_notification(@comment).deliver
        format.html { redirect_to user_entry_path(@entry.user_id, @entry.id), notice: 'Comment was successfully created.' }

      else
        format.html { renderuser_entry_path(@entry.user_id, @entry.id) }

      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @entry = Entry.find_by_user_id_and_id(current_user.id, params[:entry_id], :include => :user)
    @comment = @entry.comments.find(params[:id])
    @comment.destroy

    respond_to do |format|
      format.html { redirect_to user_entries_path }
      format.json { head :ok }
    end
  end
end
