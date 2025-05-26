class BowlingGameManager

	def initiallize(game)
		@game = game
	end

	def roll(pins_knocked_down)
		current_frame = next_playable_frame
		raise "Game is complete!" unless current_frame

		current_frame.roll(pins_knocked_down)

		# Bonus rolls are awarded here if the player is in the 10th frame
		if current_frame.number == 10 && current_frame.is_strike && current_frame.tries == 1
			current_frame.increment!(:tries) # bonus try available
		end

		if current_frame.is_complete && current_frame.number < 10
			advance_to_next_frame
		end
	end

	private

	def next_playable_frame
		@game.frames.order(:number).detect { |frame| !frame.is_complete }
	end

	def advance_to_next_frame
		current_frame = next_playable_frame
		return if current_frame.nil? || current_frame.number >= 10

		next_frame = @game.frames.find_by(number: current_frame.number + 1)

		if next_frame
			next_frame.initiallize_pins if next_frame.pins.empty?
		end
	end
end