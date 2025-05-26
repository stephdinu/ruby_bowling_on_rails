class GameScoreboardService
	def initialize(game)
		@game = game
	end

	def calculate_total_score
		total_score = 0

		frames = @game.frames.order(:position)
		frames.each_with_index do |frame, index|
			frame_score = frame.count_knocked_down_pins

			if frame.is_strike
				frame_score += award_strike_bonus(frames, index)
			elsif frame.is_spare
				frame_score += award_spare_bonus(frames, index)
			end

			total_score += frame_score
		end

		@game.player.update(score: total_score)
	end

	private

	def award_strike_bonus(frames, index)
		return 0 if index >= 9
		next_two_tries(frames, index + 1, 2)
	end

	def award_spare_bonus(frames, index)
		return 0 if index >= 9
		next_two_tries(frames, index + 1, 1)
	end

	def next_two_tries(frames, start_index, count)
		pins = []
		(start_index..9).each do |i|
			pins += frames[i].pins.where(down: true).pluck(:down)
			break if pins.size >= count
		end
		pins.first(count).count(true)
	end
end