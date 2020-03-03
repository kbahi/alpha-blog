class CategoriesController < ApplicationController
    before_action :set_category, only: [:show, :edit, :update]
    before_action :require_admin, except: [:index, :show]
    
    def new
        @category = Category.new
    end
    
    def show
        @category_articles=@category.articles.paginate(page: params[:page],per_page: 1)
    end
    
    def index
        @categories = Category.paginate(page: params[:page],per_page: 1)
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
    
    def edit
    
    end
    
    def update
        if @category.update(category_params)
            flash[:success]="Category updated !"
            redirect_to category_path(@category)
        else
            render 'edit'
        end
    end
    
    private
    
    def category_params
        params.require(:category).permit(:name)
    end
    
    def set_category
        @category = Category.find(params[:id])
    end
    
    def require_admin
        if !logged_in? || (logged_in? && !current_user.admin?)
            flash[:danger] = "Only admin can perform that action"
            redirect_to categories_path
        end
    end
    
end