class ArticlesController < ApplicationController

before_action :authenticate_user! ,except: [:index, :show]
load_and_authorize_resource
def index	
	@articles = Article.paginate(:page => params[:page], :per_page => 5)
	
	@hash = {}
	@published_articles = Article.where('published = ?',true)
	@unpublished_articles = Article.where('published = ?',false)
	@articles.each do |article|
		@hash[article.published_date.beginning_of_month] = @articles.find_all{|a| a.published_date.beginning_of_month == article.published_date.beginning_of_month }
	end
end

def new
	@article = Article.new
end

def create
	@article = Article.new(article_params)
	@article.user_id = current_user.id
	if @article.save
		redirect_to article_path(@article), notice: "Article Created Successfully."
	else 
		render action: "new"
	end
end

def show 
	@article = Article.find(params[:id])
	category_ids = @article.categories.pluck(:id)
	selected_category_ids = ArticleCategory.where(category_id: category_ids).shuffle.first(3).map(&:article_id)
	@related_articles = Article.where(id: selected_category_ids)
end

def edit
	@article = Article.find(params[:id])
end

def update
	@article = Article.find(params[:id])
	if @article.update_attributes(article_params)
		redirect_to article_path(@article) , notice: "Successfully Updated Article."
	else
		render action: "edit"
	end
end

def destroy
	@article = Article.find(params[:id])
	if @article.destroy
		redirect_to articles_path , notice: "Successfully Destroyed Article."
	else
		render action: "Show"
	end
end

private

def article_params
	params[:article].permit(:title, :published, :published_date, :body, :cover, category_ids: [])
end

end
