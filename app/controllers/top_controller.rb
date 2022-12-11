class TopController < ApplicationController
	def index
		# @reports = Report.all.order(created_at: :desc)
		@report = Report.all.joins(
			"LEFT OUTER JOIN recipes ON reports.recipe_id = recipes.id")
		.select("recipes.*")
		.order(created_at: :desc)
		# .each do |results| puts "#{results.title}: #{results.id}" end
		render json: @reports
	end
end
