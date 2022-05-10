class Api::V1::UsersController < Api::BaseController
  def index
    respond_with paginate(filtered_collection(User.all))
  end

  def show
    respond_with user
  end

  def create
    _user = User.create!(email: params[:email], password: params[:password])
    respond_with _user.authentication_token
  end

  def login
    _user = User.find_by_email!(params[:email])
    if _user.valid_password? params[:password]
      respond_with token: _user.authentication_token, user_id: _user.id
    else
      raise ActiveRecord::RecordNotFound
    end
  end

  def update
    user.update!(user_params)
    respond_with user
  end

  private

  def user
    @user ||= User.find_by!(id: params[:id])
  end

  def user_params
    params.require(:user).permit(
      :id,
      :email,
      :password
    )
  end
end