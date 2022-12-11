class ReportsController < ApplicationController
    def create
        @report = Report.create(
            gen: params[:gen],
            sex: params[:sex],
            comment: params[:comment],
            recipe_id: params[:recipe_id],
            user_id: params[:user_id],
        )
    end
end
