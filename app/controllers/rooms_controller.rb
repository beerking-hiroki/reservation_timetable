class RoomsController < ApplicationController
  def edit
    @room = current_store.rooms.find(params[:id])
  end

  def update
    @room = current_store.rooms.find(params[:id])
    if @room.update(room_params)
      flash[:notice] = "更新しました"
      if params[:capacity_only].present?
        redirect_to root_path
      else
        redirect_to store_setting_path
      end      
    else
      flash.now[:alert] = @room.errors.full_messages.join("、")
      render :edit, status: :unprocessable_entity
    end
  end

  private

    def room_params
      params.expect(room: [ :name, :min_capacity, :max_capacity ])
    end
end

