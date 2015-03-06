class UsersController < ApplicationController
   before_action :signed_in_user, only: [:index,:edit, :update]
    before_action :correct_user,   only: [:edit, :update]
    before_action :admin_user,     only: :destroy
  def index
   @users = User.paginate(page: params[:page])

  end
  def show
    @user = User.find(params[:id])
    @microposts = @user.microposts.paginate(page: params[:page])
  end
  def new
     @user = User.new
  end
  def create
    @user = User.new(params[:user])    # 実装は終わっていないことに注意!
    if @user.save
       sign_in @user
      flash[:success] = "Welcome to the Sample App!"
       redirect_to @user# 保存の成功をここで扱う。
    else
      render 'new'
    end
  end
end

  def edit
    @user = User.find(params[:id])
  end
 private

  def update
    @user = User.find(params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to @user# 更新に成功した場合を扱う。
    else
      render 'edit'
    end
  end
   def destroy
    User.find(params[:id]).destroy
    flash[:success] = "User destroyed."
    redirect_to users_url
   end
    def user_params
      params.require(:user).permit(:name, :email, :password,
                                   :password_confirmation)
    end
    # Before actions

     def correct_user
      @user = User.find(params[:id])
      redirect_to(root_path) unless current_user?(@user)
     end
     def admin_user
      redirect_to(root_path) unless current_user.admin?
     end
end
