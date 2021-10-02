# frozen_string_literal: true

require 'minitest/autorun'

require_relative '../board'

describe Board do
  describe '#play' do
    describe 'when player wins' do
      it 'results in :won' do
        board = Board.new
        [[:x, 2], [:o, 8], [:x, 6], [:o, 4], [:x, 0], [:o, 3]].each do |player, position|
          assert_equal :next, board.play(player, position)
        end
        assert_equal :won, board.play(:x, 1)

        board.print
      end
    end

    describe 'when make a wrong play' do
      it 'results in :invalid' do
        board = Board.new

        assert_equal :next, board.play(:x, 0)
        assert_equal :invalid, board.play(:o, 0)
      end
    end
  end
end
