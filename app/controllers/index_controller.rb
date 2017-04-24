class IndexController < ApplicationController

	def home
		@user = current_user
		@books = Book.all
	end

end
