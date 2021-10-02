# frozen_string_literal: true
require 'minitest/autorun'

require_relative '../state'

describe State do
  describe '#update' do
    describe 'with a valid move' do
      it 'defines status ok' do
        state = State.new
        assert_equal :next, state.update(:x, 0)
        assert_equal :x, state[0]
      end
    end

    describe 'when player wins' do
      it 'defines status won' do
        state = State.new
        [[:x, 2], [:o, 8], [:x, 6], [:o, 4], [:x, 0], [:o, 3]].each do |player, position|
          assert_equal :next, state.update(player, position)
        end
        assert_equal :won, state.update(:x, 1)
      end
    end

    describe 'with already taken index' do
      it 'results invalid' do
        state = State.new
        state.update(:x, 0)
        assert_equal :invalid, state.update(:y, 0)
        assert_equal :x, state[0]
      end
    end
  end
end
