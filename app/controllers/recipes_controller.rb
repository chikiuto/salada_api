class RecipesController < ApplicationController
    def index
        if params[:zairyou]
            @recipes = Recipe.where("material LIKE ?", "%#{params[:zairyou]}%")
			render json: @reports
            if params[:jikan]
                @recipes = @recipes.where("indication LIKE ?", "%#{params[:jikan]}%")
				render json: @reports
          	end
        end
      end
end
