class SlotsController < ApplicationController
  def new
    @slot = Slot.new(start_at: Time.current.change(min: Time.current.min / 15 * 15))
    @rooms = current_store.rooms
    @plans =  current_store.plans
  end

  def create
    @slot = Slot.new(slot_params)
    @slot.kind = :reservation
    if @slot.save
      flash[:notice] = "予約を登録しましたよん"
      redirect_to new_slot_path
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
