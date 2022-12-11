class TopController < ApplicationController
	def index
		# @reports = Report.all.order(created_at: :desc)

		@reports = Report.joins(
			"LEFT OUTER JOIN recipes 
				ON reports.recipe_id = recipes.id"
			)
			.select("reports.*", "recipes.*")
			.order(created_at: :desc)
		render json: @reports
	end
end
