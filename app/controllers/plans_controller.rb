class PlansController < ApplicationController
  def new
    @plan = current_store.plans.new
  end

  def create
    @plan = current_store.plans.new(plan_params)
    if @plan.save
      flash[:notice] = "プランを追加しましたよん"
      redirect_to store_setting_path
    else
      flash.now[:alert] = @plan.errors.full_messages.join("、")
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @plan = current_store.plans.find(params[:id])
  end

  def update
    @plan = current_store.plans.find(params[:id])
    if @plan.update(plan_params)
      flash[:notice] = "更新しました"
      redirect_to store_setting_path
    else
      flash.now[:alert] = @plan.errors.full_messages.join("、")
      render :edit, status: :unprocessable_entity
    end
  end

  private

  def plan_params
    params.expect(plan: [ :name, :start_time, :end_time, :duration_minutes ])
  end
end
