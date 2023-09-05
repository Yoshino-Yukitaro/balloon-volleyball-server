class UsersController < ApplicationController
  def index
    render json: {message: "ちーっす"}
  end
  def create
    user = User.create(name: params[:name])
    render json: user, status: :created
  end
  def show
    user = User.find_by(id: params[:id])
    render json: Error.new(404, "ユーザーが見つかりませんでした。"), status: :not_found and return if user.nil?
    render json: user
  end
  def destroy
    user = User.find_by(id: params[:id])
    render json: Error.new(404, "ユーザーが見つかりませんでした。"), status: :not_found and return if user.nil?
    user.destroy
    render json: {}
  end
end
