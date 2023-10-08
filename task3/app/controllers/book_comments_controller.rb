class BookCommentsController < ApplicationController
    def create
        comment = BookComment.new(comment_params)
        comment.user_id = current_user.id
        comment.book_id = params[:book_id]
        comment.save()
        redirect_to request.referer
    end

    def destroy
        comment = BookComment.find(params[:id])
        comment.destroy()
        redirect_to request.referer
    end

    private

    def comment_params
      params.require(:book_comment).permit(:comment)
    end
end
