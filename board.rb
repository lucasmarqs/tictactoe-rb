# frozen_string_literal: true

require_relative 'state'

class BoardFinishedException < RuntimeError; end

class Board
  def initialize
    @state = State.new
    @finished = false
  end

  def play(player, position)
    raise BoardFinishedException if finished?

    result = @state.update(player, position)
    @finished = %i[full won].include? result
    result
  end

  def finished? = @finished

  def print
    #    a   b   c
    # 1:   | X |
    #   ---|---|---
    # 2:   | X |
    #   ---|---|---
    # 3:   | X |
    #
    @state.map { |p| p || ' ' }.each_slice(3).each_with_index do |row, index|
      puts '    a   b   c' if index.zero?
      print_row row, index
    end
  end

  private

  def print_row(row, index)
    puts "#{index + 1}   #{row[0]} | #{row[1]} | #{row[2]}"
    puts '   ---|---|---' if index < 2
  end
end
