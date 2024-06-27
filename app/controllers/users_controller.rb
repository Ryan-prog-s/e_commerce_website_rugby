class UsersController < ApplicationController
  before_action :require_login, only: [:edit, :update, :become_buyer, :become_seller]
  
  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to root_path, notice: 'Account created successfully'
    else
      render :new
    end
  end

  def edit
    @user = current_user
  end

  def update
    @user = current_user
    if @user.update(user_params)
      redirect_to edit_user_path, notice: 'Profile updated successfully'
    else
      render :edit
    end
  end

  def become_buyer
    current_user.create_buyer
    redirect_to root_path, notice: 'You are now a buyer'
  end

  def become_seller
    current_user.create_seller
    redirect_to root_path, notice: 'You are now a seller'
  end

  private

  def user_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
