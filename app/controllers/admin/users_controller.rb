class Admin::UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :require_admin

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @displayed_attributes = @user.attributes.keys.reject{|k| k == 'encrypted_password'}
  end

  # GET /users/2/edit
  def edit
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to admin_user_path(@user), notice: "User was saved successfully"
    else
      render :edit
    end
  end

  # DELETE /users/1
  def destroy
    if @user.surveys.present?
      redirect_to admin_users_url, alert: "User has surveys present and cannot be deleted"
    else
      @user.destroy
      redirect_to admin_users_url, notice: "User was deleted successfully"
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(
        :organisation_name,
        :email,
        :username,
        :password,
        :password_confirmation,
        :admin
      )
    end
end
