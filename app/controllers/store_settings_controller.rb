class StoreSettingsController < ApplicationController
  def show
    @store = current_store
  end
end
