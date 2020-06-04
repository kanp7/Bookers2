class SearchController < ApplicationController
  def search
  	@range = params[:range]
  	search = params[:search]
  	@word = params[:word]

  	case @range
  	when "1"
  		@user = User.search(search,@word)
  	when "2"
  		@book = Book.search(search,@word)
  	when ""
  		redirect_back(fallback_location: root_path)
  	end
  end
end
