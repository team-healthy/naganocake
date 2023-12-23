# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
   before_action :customer_state, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end
  def after_sign_in_path_for(resource)
    root_path
  end
  # POST /resource/sign_in
  # def create
  #   super
  # end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

   private

    def customer_state
    # customerモデルに該当するメールが存在するか検索
     @customer = Customer.find_by(email: params[:customer][:email])
      if @customer
      # 　メールで検索したユーザーのパスワードとログイン画面で入力されたパスワードが一致するか
        if @customer.valid_password?(params[:customer][:password]) && (@customer.active_for_authentication? == false)
          flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"
          redirect_to new_customer_registration_path
        else
          flash[:notice] = "項目を入力してください"
        end
      else 
        # モデルに該当するメールがない場合
        flash[:notice] = "該当するユーザーが見つかりません"
      end
    end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end
