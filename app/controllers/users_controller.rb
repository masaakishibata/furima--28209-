class UsersController < ApplicationController


  def create
     add_index :users, :email, unique: true
  end


  def edit
  end

  def update # updateのコントローラの作成
    if current_user.update(user_params)
      redirect_to root_path # 編集できたらルートパスに帰る
    else
      render :edit # ユーザーでなかったらeditに戻る
    end
  end

  private

  def user_params
    params.require(:user).permit(:name, :email)
  end

end
