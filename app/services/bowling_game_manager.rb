class BowlingGameManager

	def initialize(game)
		@game = game
	end

	def roll(knocked_down_pins)
		current_frame = next_playable_frame
		raise "Game is complete!" unless current_frame

		current_frame.roll(knocked_down_pins)

		# Bonus rolls are awarded here if the player is in the 10th frame
		if is_tenth_frame(current_frame) && current_frame.is_strike && current_frame.tries == 1
			current_frame.increment!(:tries) # bonus try available
		end

		if current_frame.is_complete && current_frame.position < 10
			advance_to_next_frame
		end

		current_frame
	end

	private

	def next_playable_frame
		@game.frames.order(:position).detect { |frame| !frame.is_complete }
	end

	def advance_to_next_frame
		current_frame = next_playable_frame
		return if current_frame.nil? || current_frame.position >= 10

		next_frame = @game.frames.find_by(position: current_frame.position + 1)

		if next_frame
			next_frame.initiallize_pins if next_frame.pins.empty?
		end
	end

	def is_tenth_frame(frame)
		@game.frames.order(:position).to_a.last == frame
	end
end