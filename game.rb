# frozen_string_literal: true

require_relative 'board'

class InvalidMoveException < RuntimeError; end

class Game
  def initialize(players)
    @players = players
    @score = Array.new(players.size, 0)
    @current_player_idx = 0
    @board = Board.new
  end

  def play_turn(selected_position)
    result = @board.play(current_player, selected_position)
    case result
    when :won then score_to_player
    when :full then draw_game
    when :invalid
      raise InvalidMoveException
    else
      swap_player
    end
  end

  def print_board
    @board.print
  end

  def score
    @score.each_with_index.map { |item, idx| [@players[idx], item] }
  end

  def current_player = @players[@current_player_idx]

  private

  def swap_player
    @current_player_idx = @current_player_idx.eql?(0) ? 1 : 0
  end

  def draw_game
    puts "Draw Game!\nStarging a new game..."
    @board = Board.new
    swap_player
  end

  def score_to_player
    puts "#{current_player} won!!!\nStarting a new game..."
    @score[@current_player_idx] += 1
    @board = Board.new
    swap_player
  end
end
