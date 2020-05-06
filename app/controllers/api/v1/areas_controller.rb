class Api::V1::AreasController < ApplicationController
  def index
    @q = Area.ransack({name_i_cont: params[:q]})
    areas = @q.result(distinct: true).limit(8)
    render json: areas
  end

  def show
    area = Area.find(params[:id])
    climbs = area.all_child_routes
    render json: climbs
  end
end
