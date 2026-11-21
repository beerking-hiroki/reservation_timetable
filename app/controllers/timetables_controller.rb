class TimetablesController < ApplicationController
  def show
    @date = params[:date].present? ? Date.parse(params[:date]) : Time.zone.today
    @rooms = current_store.rooms
    @range = current_store.opening_hours(@date)
    @timeline = current_store.timeline_range(@date)
    @times = @timeline.step(15.minutes).to_a
    @times.pop
  end
end
