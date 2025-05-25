class Api::V1::FrameController < ApplicationController
	before action :set_frame, only: [:show, :update, :destroy]

	def index
		@frame = Frame.all
		render json: @frame
	end

	def show
		render json: @frame
	end

	def create
		@frame = Frame.new(frame_params)

		if @frame.save
			render json: @frame, status: :created
		else
			render json: @frame.errors, status: :unprocessable_entity
		end
	end

	def update
		if @frame.update(frame_params)
			render json: @frame
		else
			render json: @frame.errors, status: :unprocessable_entity
		end
	end

	def destroy
		@frame.destroy
		head :no_content
	end

	private

	def set_frame
		@frame = Frame.find(params[:id])
	end

	def frame_params
		params.require(:frame).permit(:type, :tries, :pins)
	end
end