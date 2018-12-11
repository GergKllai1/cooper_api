class Api::V1::PerformanceDataController < ApplicationController
    def create
        @data = PerformanceData.new(params[:perfomance_data])
        if @data.save
            render json: { message: 'All good!' }
        end
    end
end