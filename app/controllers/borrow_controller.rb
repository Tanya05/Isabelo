class BorrowController < ApplicationController
	def borrowRequest #make WL logic
		@user = current_user
		@book = Book.find(params[:id])
		@book.borrow_request_by = @user.id
		@book.borrow_status = 1 #Means that borrower has sent in the request but not accepted
		p params[:borrowed_for_week]
		@book.borrowed_for_week = params[:borrowed_for_week]
		if @book.save
      		redirect_to root_path, notice: "Added book"
    	end
	end

	def myBorrowRequests
		@user = current_user
		@users = User.all
		p @users 
		@books = Book.where(:uploaded_by_id => @user.id, :borrow_status=>1)
	end

	def acceptBorrowRequest
		@user = current_user
		@book = Book.find(params[:id])
		@book.borrow_status = 0 #accepted by lender
		if @book.save
      		redirect_to pending_path, notice: "Accepted borrow Request"
    	end	
	end

	def myConfirmedRequests
		@user = current_user
		@books = Book.where(:borrow_request_by => @user.id, :borrow_status=>0)
		# @book.borrowed_by_id = @book.borrow_request_by
		# @book.borrow_request_by=nil
		# if @book.save
  #     		redirect_to pending_path, notice: "Accepted borrow Request"
    end	

    def confirmRecieval
    	@user = current_user
		@book = Book.find(params[:id])
		@book.borrowed_by_id = @book.borrow_request_by
		@book.borrow_request_by=nil
		if @book.save
      		redirect_to confirm_book_recieved_path, notice: "Confirm That book has been recieved"
    	end	
	end

	def booksShared
		@user = current_user
		@books = Book.where(:borrow_request_by => nil, :borrow_status=>0)
	end

	def confirmReturn
		@user = current_user
		@book = Book.find(params[:id])
		@book.borrowed_by_id = nil
		@book.borrow_status = nil
		@book.borrow_request_by= @book.WL1_id
		@book.WL1_id= @book.WL2_id
		@book.WL2_id= @book.WL3_id
		@book.WL3_id=nil
		if @book.save
      		redirect_to shared_path, notice: "Book Recieved"
    	end	
	end
end
