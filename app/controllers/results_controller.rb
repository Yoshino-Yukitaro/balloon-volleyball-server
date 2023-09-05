class ResultsController < ApplicationController
  def index
    result = Result.eager_load(:users).all
    render json: { results: result.map{|r| r.attributes.merge({players: r.users})} }
  end

  def create
    player_ids = params[:player_ids]
    players = User.where(id: player_ids)
    ApplicationRecord.transaction do
      result = Result.create(point: params[:point])
      players.each do |player|
        Participant.create(user: player, result: result)
      end
    end
    render json: {}, status: :created
  end
end
