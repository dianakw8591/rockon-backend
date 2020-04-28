class Api::V1::UserClimbsController < ApplicationController

  def index
    entries = request_user.user_climbs
    render json: entries
  end

  def create
    entry = request_user.user_climbs.create!(entry_params)
    render json: entry
  end

  private

  def entry_params
      params.require(:entry).permit(:climb_id, :pitches, :start_date, :end_date, :style, :led_pitches, :outcome, :highlight, :partners, :rack, :beta, :notes)
  end

  def request_user
    User.find(params[:user_id])
  end
end
