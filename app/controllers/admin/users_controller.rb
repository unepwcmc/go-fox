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
    @user.destroy
    redirect_to admin_users_url, notice: "User was deleted successfully"
  end

  def export
    CsvUserExporterJob.perform_later(current_user.email)
    redirect_to admin_users_url, notice: "Your CSV is being generated, we will send an email to #{current_user.email} when it is ready to download"
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
