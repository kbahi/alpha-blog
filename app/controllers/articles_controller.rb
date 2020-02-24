class ArticlesController < ApplicationController
    
    def new
        @article = Article.new
    end
    
    def show
        @article = Article.find(params[:id])
    end
    
    def create
        #render plain: params[:article].inspecte
        @article = Article.new(article_params)
        if @article.save
            flash[:notice]="article saved !"
            redirect_to article_path(@article)
        else
            render 'new'
        end
    end
    
    def index
    end
    
    private
    
    def article_params
        params.require(:article).permit(:title, :description)
    end
    
end