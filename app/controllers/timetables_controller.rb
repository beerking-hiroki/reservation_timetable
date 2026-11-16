class TimetablesController < ApplicationController 

  def show
    @rooms = current_store.rooms
  end

end