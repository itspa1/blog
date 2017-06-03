class CommentsController < ApplicationController

before_action :authenticate_user! , only: [:create, :destroy]
load_and_authorize_resource
	def create
			@comment = Comment.new(comment_params)
			@comment.user_id = current_user.id 
			@comment.save
	end

	def show
		@comments = Comment.where('user_id = ?', current_user)
	end

	def destroy
		@comment = Comment.find(params[:id])
		@comment.destroy
	end


	private

	def comment_params
		params[:comment].permit(:title, :body, :article_id)
	end
end
