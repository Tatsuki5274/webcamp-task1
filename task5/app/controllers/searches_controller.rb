class SearchesController < ApplicationController
    def search
        search__raw_text = params[:text]
        search_method = params[:search_method]
        search_target = params[:search_target]
        search_text = ""

        if search_method == "match" then
            search_text = search__raw_text
        elsif search_method == "left_match" then
            search_text = search__raw_text + "%"
        elsif search_method == "right_match" then
            search_text = "%" + search__raw_text
        elsif search_method == "part_match" then
            search_text = "%" + search__raw_text + "%"
        end

        
        # @books = Book.where(title: search_text).or(Book.where(body: search_text))
        @books = Book.where("title like ?", search_text).or(Book.where("body like ?", search_text))
        render "books/search_result"
    end
end
