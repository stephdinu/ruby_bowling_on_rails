class Api::V1::PinController < ApplicationController
	before_action :set_pin, only: [:show, :update, :destroy]

	def index
		@pin = Pin.all
		render json: @pin
	end

	def show
		render json: @pin
	end

	def create
		@pin = Pin.new(pin_params)

		if @pin.save
			render json: @pin, status: :created
		else
			render json: @pin.errors, status: :unprocessable_entity
		end
	end

	def update
		if @pin.update(pin_params)
			render json: @pin
		else
			render json: @pin.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@pin.destroy
		head :no_content
	end

	private

	def set_pin
		@pin = Pin.find(params[:id])
	end

	def pin_params
		params.require(:pin).permit(:down)
	end
end
