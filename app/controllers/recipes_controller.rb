class RecipesController < ApplicationController
	def index
		if params[:zairyou]
			@recipes = Recipe.where("material LIKE ?", "%#{params[:zairyou]}%")
			render json: @recipes
			if params[:jikan]
				@recipes = @recipes.where("indication LIKE ?", "%#{params[:jikan]}%")
				render json: @recipes
		  end
		end
		# @recipes = Recipe.all.order(created_at: :desc)
		# render json: @recipes
	end
end
