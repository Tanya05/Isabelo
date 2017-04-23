class BorrowController < ApplicationController
	def borrowRequest
		@user = current_user
		@book = Book.find(params[:id])
		@book.borrow_request_by = @user.id
		@book.borrow_status = 1
		p params[:borrowed_for_week]
		@book.borrowed_for_week = params[:borrowed_for_week]
		if @book.save
      		redirect_to root_path, notice: "Added book"
    	end
	end
end
