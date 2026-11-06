class TimetablesController < ApplicationController 

  def show
    @rooms = current_store.rooms
    @range = current_store.opening_hours(Time.zone.today)
  end

end