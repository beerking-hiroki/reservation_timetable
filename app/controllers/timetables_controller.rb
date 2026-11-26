class TimetablesController < ApplicationController
  def show
    @date = params[:date].present? ? Date.parse(params[:date]) : Time.zone.today
    @rooms = current_store.rooms.order(:name)
    @range = current_store.opening_hours(@date)
    @timeline = current_store.timeline_range(@date)
    @times = @timeline.step(15.minutes).to_a
    @times.pop
    @overlapped_rooms = @rooms.select do | room |
      slots = room.slots.where(start_at: @range).to_a
      slots.combination(2).any? { |x, y| x.overlaps_with?(y) }
    end
      if @overlapped_rooms.present?
        flash.now[:alert] = "#{@overlapped_rooms.map(&:name).join("、")}で予約が重なっています"
      end
  end
end
