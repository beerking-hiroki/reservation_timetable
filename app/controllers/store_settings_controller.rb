class StoreSettingsController < ApplicationController
  def show
    @store = current_store
  end

  def edit
    @store = current_store
  end

  def update
    @store = current_store
    if @store.update(store_params)
      flash[:notice] = "更新しました"
      redirect_to store_setting_path
    else
      flash.now[:alert] = @store.errors.full_messages.join("、")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def store_params
    params.expect(store: [ :name, :open_time, :close_time ])
  end
end
