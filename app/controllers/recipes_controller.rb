class RecipesController < ApplicationController
	def index
		if params[:jikan]
			@recipes = Recipe.where("indication LIKE ?", "%#{params[:jikan]}%")
			if params[:zairyou]
				@recipes = @recipes.where("material LIKE ?", "%#{params[:zairyou]}%")
			end
			render json: @recipes
		end
	end
end
