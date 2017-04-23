class BooksController < ApplicationController
	  def new
		  @book = Book.new
      @user = current_user
    end

    def show
      @book = Book.find(params[:id])
    end

    def create
    	@user = current_user
      book_params[:uploaded_by_id] = @user.id
      @book = Book.new(book_params)
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
      @user = current_user
    	defaults = { uploaded_by_id: current_user.id}
      params.require(:book).permit(:title, :author,:genre, :isbn, :shared_for_week).merge(defaults)
    	#private method so hackers can't access by sending requests like in sqlengine attacks
    	#only permitted values and not entire table made visible
  	end

    def search_params
      params.require(:book).permit(:search)
    end

end
