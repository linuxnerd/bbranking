class UsersController < ApplicationController
  before_action :signed_in_user, only: [:edit, :update, :show]
  before_action :admin_user, only: :destroy

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      sign_in @user
      @user.update_attribute(:last_ip, request.remote_ip)
      redirect_to root_path, :flash => { :success=>"欢迎登录" }
    else
      render 'new'
    end
  end

  def show
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      sign_in @user
      redirect_to edit_user_path(@user), :flash => { :success=>"资料修改完成" }
    else
      render 'edit'
    end
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    flash[:success] = "#{@user.name} 被成功删除!"
    redirect_to users_url
  end

  def password
    @user = User.find(params[:id])
  end

  def change_password
    @user = User.find(params[:id])
    if @user.update_password(user_params)
      #sign_in @user
      redirect_to root_path, :flash => { :success=>"密码修改成功" }
    else
      render 'password'
    end
  end

  private
    def user_params
      params.require(:user).permit(:name, :email, :phone,
                      :password, :password_confirmation, :current_password)
    end

    def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
    end

    def admin_user
      redirect_to(root_path) unless current_user.admin?
    end
end
