class NotificationsController < ApplicationController
	def index
		@user = current_user
		generateNotifications()
		@notificationsBorrowed = Notification.where(:user_id_for => @user.id, :seen=>nil)	
		@notificationsLent = Notification.where(:user_id_about => @user.id, :seen=>nil)	
	end

	def generateNotifications
		@user = current_user
		@booksborrowedbyme = Book.where(:borrowed_by_id => @user.id)
		for @book in @booksborrowedbyme
			if @book.bookSharedTill != nil #Deadline for books borrowed
				if Date.today > (@book.bookSharedTill)
					@existing = Notification.where(:user_id_for => @user.id, :notifType=>2, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)
					if @existing.blank?
						@notification = Notification.new(:user_id_for => @user.id, :notifType=>2, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)#notifType =2 means return deadline reached
						@notification.save
					end
				elsif Date.today > (@book.bookSharedTill-3.days)
					@existing = Notification.where(:user_id_for => @user.id, :notifType=>1, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)
					if @existing.blank?
						@notification = Notification.new(:user_id_for => @user.id, :notifType=>1, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)#notifType =2 means return deadline reached#notifType =1 means retuen deadline approaching	
						@notification.save
					end
				end
			end
		end
		
		@bookslentbyme = Book.where(:uploaded_by_id => @user.id)
		for @book in @bookslentbyme
			if @book.bookSharedTill != nil #Deadline for books borrowed
				if Date.today > (@book.bookSharedTill)
					@existing = Notification.where(:user_id_for => @book.borrowed_by_id, :notifType=>2, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)
					if @existing.blank?
						@notification = Notification.new(:user_id_for => @book.borrowed_by_id, :notifType=>2, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)#notifType =2 means return deadline reached
						@notification.save
					end
				elsif Date.today > (@book.bookSharedTill-3.days)
					@existing = Notification.where(:user_id_for => @book.borrowed_by_id, :notifType=>1, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)
					if @existing.blank?
						@notification = Notification.new(:user_id_for => @book.borrowed_by_id, :notifType=>1, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)#notifType =2 means return deadline reached#notifType =1 means retuen deadline approaching	
						@notification.save
					end
				end
			end
		end

		@booksRequests = Book.where(:uploaded_by_id => @user.id, :borrow_status=>1)
		for @book in @booksRequests#notifType 3 means borrow request
			@existing = Notification.where(:user_id_for => @book.uploaded_by_id, :notifType=>3, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.borrow_request_by)
			if @existing.blank?
				@notification = Notification.new(:user_id_for => @book.uploaded_by_id, :notifType=>3, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.borrow_request_by)#notifType =3 means borrow requests reached#notifType =1 means retuen deadline approaching	
				@notification.save
			end
		end

	end

end
	