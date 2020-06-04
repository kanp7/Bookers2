class BookCommentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@book = Book.find(params[:book_id])
		comment = BookComment.new(post_comment_params)
		comment.user_id = current_user.id
		comment.book_id = @book.id
		comment.save
		render "comment_index"
	end

	def destroy
		BookComment.find_by(id: params[:id], book_id: params[:book_id]).destroy
		redirect_to book_path(params[:book_id])
	end

	private
	def post_comment_params
		params.require(:book_comment).permit(:comment)
	end

end
