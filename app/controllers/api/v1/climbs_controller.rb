class Api::V1::ClimbsController < ApplicationController
  def index
    @q = Climb.ransack({name_i_cont: params[:q]})
    climbs = @q.result(distinct: true)
    render json: {climbs: climbs}
  end
end
