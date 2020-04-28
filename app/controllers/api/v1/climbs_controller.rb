class Api::V1::ClimbsController < ApplicationController
  def index
    @q = Climb.ransack({name_i_cont: params[:q]})
    climbs = @q.result(distinct: true).limit(8)
    render json: {climbs: climbs}
  end
end
