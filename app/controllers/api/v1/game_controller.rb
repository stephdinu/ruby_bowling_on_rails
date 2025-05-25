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
		@game = Game.new(game_params)

		if @game.save
			render json: @game, status: :created
		else
			render json: @game.errors, status: :unprocessable_entity
		end
	end

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