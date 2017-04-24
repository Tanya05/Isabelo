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
				if Date.today < (@book.bookSharedTill)
					@existing = Notification.where(:user_id_for => @user.id, :notifType=>2, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)
					p @existing
					p "awdawdawdawdwd"
					if @existing.blank?
						@notification = Notification.new(:user_id_for => @user.id, :notifType=>2, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)#notifType =2 means return deadline reached
						@notification.save
					end
				elsif Date.today <= (@book.bookSharedTill+3.days)
					@existing = Notification.where(:user_id_for => @user.id, :notifType=>1, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)
					if @existing.blank?
						@notification = Notification.new(:user_id_for => @user.id, :notifType=>1, :book_id=>@book.id, :deadline=>@book.bookSharedTill, :user_id_about=>@book.uploaded_by_id)#notifType =2 means return deadline reached#notifType =1 means retuen deadline approaching	
						@notification.save
					end
				end
			end
		end
		# @bookslentbyme = Book.where(:uploaded_by_id => @user.id)
		# for @book in @bookslentbyme
		# 	if @book.bookSharedTill != nil #Deadline for books lent
		# 		if Date.today < (@book.bookSharedTill)
		# 			@notification = Notification.new(:user_id_for => @user.id, :notifType=>2, :book_id=>@book.id, :deadline=>bookSharedTill, :user_id_about=>@book.uploaded_by_id)#notifType =2 means return deadline reached
		# 			@notification.save
		# 		elsif Date.today <= (@book.bookSharedTill+3.days)
		# 			@notification = Notification.new(:user_id_for => @user.id, :notifType=>1, :book_id=>@book.id, :deadline=>bookSharedTill, :user_id_about=>@book.uploaded_by_id)#notifType =1 means retuen deadline approaching	
		# 			@notification.save
		# 		end
		# 	end
		# end
	end
end
	