class SkillsController < ApplicationController
  def index
    render json: {skills: [{ id: 1, name: "縮小化", description: "ヒットした瞬間にボールを縮小化する。" }]}
  end
end
