# frozen_string_literal: true

require_relative 'game'

puts 'Welcome to Tic Tac Toe!!!'

game = Game.new(%w[X O])

COLUMNS = { 'a' => 0, 'b' => 1, 'c' => 2 }.freeze
def selected_position(input)
  column, row = input.split(',')
  COLUMNS[column] + (row.to_i - 1) * 3
end

def format_score(score)
  score.map { |p, s| "#{p} => #{s}" }.join(', ')
end

puts 'Starting a new game'

loop do
  puts "Next player: #{game.current_player}"
  puts 'Select a position in the format: column,line'
  puts
  game.print_board
  puts
  puts '>'
  input = gets.chomp
  game.play_turn(selected_position(input))
rescue InvalidMoveException
  puts 'Position already taken. Choosen another to continue'
rescue Interrupt
  puts 'Finishing game...'
  puts "The score is: #{format_score(game.score)}"
  puts 'Bye!'
  break
end
