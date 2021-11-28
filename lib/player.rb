# frozen_string_literal: true

class Player
  attr_accessor :name, :kill_times, :was_not_killed_times, :was_killed_times

  def initialize(name, kill_times = 0, was_not_killed_times = 0, was_killed_times = 0)
    @name = name
    @kill_times = kill_times
    @was_not_killed_times = was_not_killed_times
    @was_killed_times = was_killed_times
  end

  def kill(player)
    return player.was_killed_times += 1 if self == player || name == '<world>'

    @kill_times += 1
    player.was_not_killed_times += 1
  end

  def kills
    kill_times - was_killed_times
  end

  def ==(other)
    other.name == name
  end
end
