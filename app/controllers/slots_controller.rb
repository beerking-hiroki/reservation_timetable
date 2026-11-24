class SlotsController < ApplicationController
  def new
    start_at = params[:start_at].present? ? params[:start_at] : Time.current.change(min: Time.current.min / 15 * 15)
    @slot = Slot.new(room_id: params[:room_id], start_at: start_at, kind: params[:quick].present? ? :walk_in : :reservation)
    @rooms = current_store.rooms
    @plans =  current_store.plans
  end

  def create
    @slot = Slot.new(slot_params)
    confirm_room_and_plan
    set_end_at
    if @slot.save
      flash[:notice] = "予約を登録しました"
      redirect_to root_path
    else
      flash.now[:alert] = @slot.errors.full_messages.join("、")
      @rooms = current_store.rooms
      @plans =  current_store.plans
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @slot = current_store.slots.find(params[:id])
    @rooms = current_store.rooms
    @plans =  current_store.plans
  end

  def update
    @slot = current_store.slots.find(params[:id])
    confirm_room_and_plan
    @slot.assign_attributes(slot_params)
    set_end_at
    if @slot.save
      flash[:notice] = "更新しました"
      redirect_to root_path
    else
      flash.now[:alert] = @slot.errors.full_messages.join("、")
      @rooms = current_store.rooms
      @plans = current_store.plans
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @slot = current_store.slots.find(params[:id])
    if @slot.destroy
      flash[:notice] = "削除しました"
      redirect_to root_path, status: :see_other
    else
      flash.now[:alert] = @slot.errors.full_messages.join("、")
      @rooms = current_store.rooms
      @plans = current_store.plans
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def slot_params
    params.expect(slot: [ :name, :tel, :headcount, :room_id, :plan_id, :start_at, :end_at, :kind ])
  end

  def confirm_room_and_plan
    current_store.rooms.find(slot_params[:room_id])
    if slot_params[:plan_id].present?
      current_store.plans.find(slot_params[:plan_id])
    end
  end

  def set_end_at
    if @slot.plan && @slot.plan.duration_minutes
      @slot.end_at = @slot.start_at + @slot.plan.duration_minutes.minutes
    elsif @slot.plan && @slot.plan.end_time
      @slot.end_at = @slot.start_at.change(hour: @slot.plan.end_time.hour, min: @slot.plan.end_time.min)
      if @slot.end_at < @slot.start_at
        @slot.end_at = @slot.end_at + 1.day
      end
    elsif @slot.end_at.blank?
      @slot.end_at = @slot.start_at + 2.hours
    end
  end
end
