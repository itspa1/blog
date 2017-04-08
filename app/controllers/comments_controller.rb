class CommentsController < ApplicationController

before_action :authenticate_user! , only: [:create, :destroy]
load_and_authorize_resource
	def create
			@comment = Comment.new(comment_params)
			@comment.user_id = current_user.id
		if user_signed_in? 
			if @comment.save
				redirect_to article_path(@comment.article_id)
			else
				render action: :back
			end
		else
			redirect_to new_user_sign_up, notice: "You Need To Log In Or Sign Up Before Adding Comment"
		end
	end

	def show
		@comments = Comment.where('user_id = ?', current_user)
	end

	def destroy
		@comment = Comment.find(params[:id])
		if @comment.destroy 
			redirect_to :back
		end
	end


	private

	def comment_params
		params[:comment].permit(:title, :body, :article_id)
	end
end
