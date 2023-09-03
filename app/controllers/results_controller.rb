class ResultsController < ApplicationController
  def index
    render json: {results: [{ id: 1, winner_id: 1, point: 100, created_at: Time.zone.now, players: [{id: 1, name: 'John Doe', skills: [{ id: 1, name: "縮小化", description: "ヒットした瞬間にボールを縮小化する。" }]}] }]}
  end

  def create
    render json: {}, status: :created
  end
end
