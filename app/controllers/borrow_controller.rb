class BorrowController < ApplicationController
	def borrowRequest 
		@user = current_user
		@book = Book.find(params[:id])
		if 	@user.id != @book.borrow_request_by and @user.id != @book.WL1_id and @user.id != @book.WL2_id and @user.id != @book.WL3_id
			if 	@book.borrow_request_by == nil and @book.WL1_id == nil
				@book.borrow_request_by = @user.id
				@book.borrow_status = 1 #Means that borrower has sent in the request but not accepted
				p params[:borrowed_for_week]
				@book.borrowed_for_week = params[:borrowed_for_week]		    
		    elsif @book.borrow_request_by != nil and @book.WL1_id == nil 
		    	@book.WL1_id = @user.id
		    	@book.WL1RequestWeeks = params[:borrowed_for_week]
		    elsif @book.borrow_request_by != nil and @book.WL1_id != nil and @book.WL2_id==nil
		    	@book.WL2_id = @user.id
		    	@book.WL2RequestWeeks = params[:borrowed_for_week]
		    elsif @book.borrow_request_by != nil and @book.WL1_id != nil and @book.WL2_id!=nil and @book.WL2_id==nil
		    	@book.WL3_id = @user.id
		    	@book.WL3RequestWeeks = params[:borrowed_for_week]
		    end	
		    if @book.save
		    	redirect_to root_path, notice: "Added book"
		    end
		else
			redirect_to root_path, notice: "You are already in the queue or your request is pending"
		end
	end

	


	def borrowedBooks
		@user = current_user
		@books = Book.where(:borrowed_by_id => @user.id)
	end

	

	def myBorrowRequests
		@user = current_user
		@users = User.all
		@books = Book.where(:uploaded_by_id => @user.id, :borrow_status=>1)
	end

	

	def acceptBorrowRequest #generate notification for the same
		@user = current_user
		@book = Book.find(params[:id])
		@book.borrow_status = 0 #accepted by lender
		@book.bookSharedOn = Time.now
		@book.bookSharedTill = Time.now + (7*@book.borrowed_for_week).days
		if @book.save
      		redirect_to pending_path, notice: "Accepted borrow Request"
    	end	
    	#notifType 4 means accepted
    	@notification = Notification.new(:user_id_for => @user.id, :notifType=>4, :book_id=>@book.id, :deadline=>nil, :user_id_about=>nil)
    	@notification.save
	end

	

	def rejectBorrowRequest #generate notification for the same
		@user = current_user
		@book = Book.find(params[:id])
		@book.borrowed_by_id = nil
		if @book.WL1_id==nil
			@book.borrow_status = nil
		else
			@book.borrow_status=1
		end
		@book.borrow_request_by= @book.WL1_id
		@book.borrowed_for_week = @book.WL1RequestWeeks
		@book.WL1_id= @book.WL2_id
		@book.WL1RequestWeeks = @book.WL2RequestWeeks
		@book.WL2_id= @book.WL3_id
		@book.WL2RequestWeeks = @book.WL3RequestWeeks
		@book.WL3_id=nil
		@book.WL3RequestWeeks = nil
		if @book.save
      		redirect_to pending_path, notice: "Book Recieved"
    	end
    	#notifType 5 means rejected
    	@notification = Notification.new(:user_id_for => @user.id, :notifType=>5, :book_id=>@book.id, :deadline=>nil, :user_id_about=>nil)
    	@notification.save
	end

	

	def myConfirmedRequests
		@user = current_user
		@books = Book.where(:borrow_request_by => @user.id, :borrow_status=>0)
		@notyetacceptedbooks = Book.where(:borrow_request_by => @user.id, :borrow_status=>1)
		
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
      		redirect_to pending_recievals_path, notice: "Confirm That book has been recieved"
    	end	
	end

	

	def booksShared
		@user = current_user
		@books = Book.where(:uploaded_by_id => @user.id)
	end

	

	def confirmReturn
		@user = current_user
		@book = Book.find(params[:id])
		@book.borrowed_by_id = nil
		@book.borrow_status = nil
		@book.borrow_request_by= @book.WL1_id
		@book.borrowed_for_week = @book.WL1RequestWeeks
		@book.WL1_id= @book.WL2_id
		@book.WL1RequestWeeks = @book.WL2RequestWeeks
		@book.WL2_id= @book.WL3_id
		@book.WL2RequestWeeks = @book.WL3RequestWeeks
		@book.WL3_id=nil
		@book.WL3RequestWeeks = nil
		if @book.save
      		redirect_to shared_path, notice: "Book Recieved"
    	end	
	end
end
