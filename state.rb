# frozen_string_literal: true

require 'set'

class State
  include Enumerable

  def initialize
    @state = Array.new(9)
  end

  def update(player, position)
    if @state[position].nil?
      @state[position] = player
      player_won?(player)
    else
      :invalid
    end
  end

  def full?
    @state.none? nil
  end

  def [](idx) = @state[idx]

  def each(&block) = @state.each(&block)

  private

  def player_won?(player)
    members = @state.each_with_index.filter_map { |p, idx| idx if p.eql? player }.to_set

    members.each do |state_position|
      conditions_to_win(state_position).each do |set|
        return :won if set.subset?(members)
      end
    end

    full? ? :full : :next
  end

  def conditions_to_win(state_position)
    [
      Set[state_position, state_position + 1, state_position + 2],
      Set[state_position, state_position + 3, state_position + 6],
      Set[0, 4, 8],
      Set[2, 4, 6]
    ]
  end
end
