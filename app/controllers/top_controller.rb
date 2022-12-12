class TopController < ApplicationController
	def index
		@reports = Report
			.select( "reports.*", "recipes.*" )
			.joins( "LEFT JOIN recipes ON reports.recipe_id = recipes.id" )
			.order( created_at: :desc );
		render json: @reports
	end
end
