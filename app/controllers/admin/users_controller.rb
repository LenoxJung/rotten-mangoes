class Admin::UsersController < ApplicationController
  before_action :admins_only, except: [:switchback]
  def index
    @users = User.all.page(params[:page]).per(10)
  end

  def edit
    @user = User.find(params[:id])
  end 

  def destroy
    @user = User.find(params[:id])
    @user.reviews.each do |review|
      review.destroy
    end
    @user.destroy
    UserMailer.delete_email(@user)
    redirect_to admin_users_path
  end

  def show
    @user = User.find(params[:id])
  end

  def switch
    session[:admin_id] = current_user.id
    session[:user_id] = params[:user_id]
    redirect_to movies_path
  end

  def switchback
    puts "ROHIT DHAND WELCOME"
    session[:user_id] = session[:admin_id]
    session[:admin_id] = nil
    redirect_to movies_path
  end

end
