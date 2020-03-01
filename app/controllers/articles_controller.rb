class ArticlesController < ApplicationController
    before_action :set_article, only: [:edit, :update, :show, :destroy]
    before_action :require_user, except: [:show, :index]
    before_action :require_same_user, only: [:edit, :update, :destroy]
    
    def new
        @article = Article.new
    end
    
    def edit 
    end
    
    def update 
        if @article.update(article_params)
            flash[:success]="article saved !"
            redirect_to article_path(@article)
        else
            render 'edit'
        end
    end
    
    def show
        
    end
    
    def create
        @article = Article.new(article_params)
        @article.user = User.first
        if @article.save
            flash[:success]="article saved !"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end
    
    def index
        @articles=Article.paginate(page: params[:page], per_page: 1)
    end 
    
    def destroy
        @article.destroy
        flash[:danger]="Article deleted !"
        redirect_to articles_path
    end
    
    private
    
    def set_article
        @article = Article.find(params[:id])
    end
    
    def article_params
        params.require(:article).permit(:title, :description)
    end
    
    def require_same_user
        if current_user != @article.user
            flash[:danger] = "You can only edit or delete your own articles"
            redirect_to root_path
        end
    end
    
end