class SearchController < ApplicationController

  
  def index
  	@user = current_user
  	if params[:search]
  		search(params[:search])
  	end
  end
  
  def search(search)
    @books = Book.where("title like ? OR author like ?", "%#{search}%", "%#{search}%")
  end

  def searchInit
  	@user= current_user
  end
end
