class SlotsController < ApplicationController
  def new
    @slot = Slot.new(start_at: Time.current.change(min: Time.current.min / 15 * 15))
    @rooms = current_store.rooms
    @plans =  current_store.plans
  end

  def create
    @slot = Slot.new(slot_params)
    @slot.kind = :reservation
    if @slot.plan && @slot.plan.duration_minutes
      @slot.end_at = @slot.start_at + @slot.plan.duration_minutes.minutes
    elsif @slot.plan && @slot.plan.end_time
      @slot.end_at = @slot.start_at.change(hour: @slot.plan.end_time.hour, min: @slot.plan.end_time.min)
      if @slot.end_at < @slot.start_at
        @slot.end_at = @slot.end_at + 1.day
      end
    end
    if @slot.save
      flash[:notice] = "予約を登録しましたよん"
      redirect_to root_path
    else
      flash.now[:alert] = @slot.errors.full_messages.join("、")
      @rooms = current_store.rooms
      @plans =  current_store.plans
      render :new, status: :unprocessable_entity
    end
  end

  private

  def slot_params
    params.expect(slot: [ :name, :tel, :headcount, :room_id, :plan_id, :start_at, :end_at ])
  end
end
