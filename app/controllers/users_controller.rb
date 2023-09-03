class UsersController < ApplicationController
  def index
    render json: {message: "ちーっす"}
  end
  def create
    render json: {}, status: :created
  end
  def show
    render json: {id: 1, name: 'John Doe', skills: [{ id: 1, name: "縮小化", description: "ヒットした瞬間にボールを縮小化する。" }]}
  end
  def destroy
    render json: {}
  end
  def skills
    render json: {skills: [{ id: 1, name: "縮小化", description: "ヒットした瞬間にボールを縮小化する。" }]}
  end
end
