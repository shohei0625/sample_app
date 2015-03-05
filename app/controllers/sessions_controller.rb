class SessionsController < ApplicationController
  
    def new
    end

  def create
      user = User.find_by(email: params[:session][:email].downcase)
  if user && user.authenticate(params[:session][:password])
      sign_in user
      redirect_to user # ユーザーをサインインさせ、ユーザーページ (show) にリダイレクトする。
  else
     flash.now[:error] = 'Invalid email/password combination' # 誤りあり!
      render 'new'# エラーメッセージを表示し、サインインフォームを再描画する。
  end
  end

  def destroy
      sign_out
    redirect_to root_url
  end
end
