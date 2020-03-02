class CategoriesController < ApplicationController
    
    def new
        @category = Category.new
    end
    
    def show
        
    end
    
    def index
        @categories = Category.paginate(page: params[:page],per_page: 3)
    end
    
    def create 
        @category = Category.new(category_params)
        if @category.save
            flash[:success] =  "Category created successfully"
            redirect_to categories_path(@category)
        else
            render 'new'
        end
    end
    
    private
    
    def category_params
        params.require(:category).permit(:name)
    end
    
end