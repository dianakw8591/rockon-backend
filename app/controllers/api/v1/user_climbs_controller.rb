class Api::V1::UserClimbsController < ApplicationController

  def index
    entries = request_user.user_climbs
    render json: entries
  end

  def create
    entry = request_user.user_climbs.create!(entry_params)
    render json: entry
  end

  def update
    entry = UserClimb.find(params[:id])
    entry.update(entry_params)
    if entry.valid?  
      render json: entry
    else
      render json: { error: entry.errors.full_messages }, status: :not_acceptable
    end
  end

  def destroy
    entry = UserClimb.find(params[:id])
    entry.destroy
    render json: {message: "Entry successfully deleted"} 
  end

  private

  def entry_params
      params.require(:entry).permit(:climb_id, :pitches, :start_date, :end_date, :style, :led_pitches, :outcome, :highlight, :partners, :rack, :beta, :notes)
  end

  def request_user
    User.find(params[:user_id])
  end
end
