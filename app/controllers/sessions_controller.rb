class SessionsController < ApplicationController 

  skip_before_action :require_login, only: [:new, :create]

  # ログイン処理
  def new  
  end

  # ログインフォーム送信処理
  def create
    store = Store.find_by(email: params[:email])
    if store && store.authenticate(params[:password])
      session[:store_id] = store.id
      redirect_to root_path
    else
      flash.now[:alert] = "メールアドレスまたはパスワードが違います"
      render :new, status: :unprocessable_entity
    end
  end

  def destroy
    session.delete(:store_id)
    redirect_to login_path, status: :see_other
  end

end
