class Api::V1::GameController < ApplicationController
	before action :set_game, only: [:show, :update, :destroy]

	def index
		@game = Game.all
		render json: @game
	end

	def show
		render json: @game
	end

	def create
		player = Player.find(params[:player_id])
		@game = player.games.create!

		if @game.save
			render json: @game, status: :created
		else
			render json: @game.errors, status: :unprocessable_entity
		end
	end

	def show
		game = Game.find(params[:id])
		render json: game, include: { frames: { include: :pins} }

	def update
		if @game.update(game)
			render json: @game
		else
			render json: @game.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@game.destroy
		head :no_content
	end

	private

	def set_game
		@game = Game.find(params[:id])
	end

	def game_params
		params.require(:game).permit(:type, :tries, :pins)
	end
end