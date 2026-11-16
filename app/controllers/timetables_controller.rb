class TimetablesController < ApplicationController 

  def show
    @rooms = current_store.rooms
    @range = current_store.opening_hours(Time.zone.today)
    @timeline = current_store.timeline_range(Time.zone.today)
    @times = @timeline.step(15.minutes).to_a
  end

end