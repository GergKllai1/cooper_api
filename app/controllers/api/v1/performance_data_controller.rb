class Api::V1::PerformanceDataController < ApplicationController

    before_action :authenticate_api_v1_user!

    def create
        @data = PerformanceData.new(perfomance_data_params.merge(user: current_api_v1_user))
        if @data.save
            render json: { message: 'All good!' }
        else
            render json: { error: @data.errors.full_messages }
        end
    end

    private

    def perfomance_data_params
        params.require(:perfomance_data).permit!
    end
end