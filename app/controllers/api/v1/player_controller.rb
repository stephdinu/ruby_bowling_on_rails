class Api::V1::PlayerController < ApplicationController
	before action :set_player, only: [:show, :update, :destroy]

	def index
		@player = Player.all
		render json: @player
	end

	def show
		render json: @player
	end

	def create
		@player = Player.new(player_params)

		if @player.save
			render json: @player, status: :created
		else
			render json: @player.errors, status: :unprocessable_entity
		end
	end

	def show
		player = Player.find(params[:id])
		render json: player
	end

	def update
		if @player.update(player_params)
			render json: @player
		else
			render json: @player.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@player.destroy
		head :no_content
	end

	private

	def set_player
		@player = Player.find(params[:id])
	end

	def player_params
		params.require(:player).permit(:name)
	end
end