class SessionsController < ApplicationController

  def new
  end

  def create
    user = User.find_by(email: params[:session][:email].downcase)
    if user && user.authenticate(params[:session][:password])
      sign_in user
      user.update_attribute(:last_ip, request.remote_ip)
      redirect_back_or dashboard_index_path
    else
      flash.now[:danger] = '用户名 / 密码不正确'
      render 'new'
    end
  end

  def destroy
    sign_out
    redirect_to root_path
  end
end
