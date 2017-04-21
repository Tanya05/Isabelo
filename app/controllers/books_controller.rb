class BooksController < ApplicationController
	def new
		@book = Book.new
    @user = current_user
    end

    def create
    	@book = Book.new(book_params)
      @user = current_user
    	if @book.save
      		redirect_to root_path, notice: "Added book"
    	else
      		render "new"
    	end
  	end

  	def destroy
    	@book = Book.find(params[:id])
    	@book.destroy
    	redirect_to ip_book_ip_path, notice:  "The book #{@book.title} has been deleted."
  	end

  	private
  	def book_params
    	params.require(:book).permit(:title, :author,:genre, :isbn, :uploaded_by_id, :shared_for_week)
    	#private method so hackers can't access by sending requests like in sqlengine attacks
    	#only permitted values and not entire table made visible
  	end
end
