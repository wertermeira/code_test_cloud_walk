# frozen_string_literal: true

require_relative '../lib/read_log'
require_relative  '../lib/utils'
require_relative  '../lib/means_of_death'
require_relative  '../lib/game'

class ParseLog
  include Utils
  attr_reader :games, :current_game, :lines, :means_of_death

  def initialize(file_path = '../../logs/game.log')
    @games = []
    @current_game = nil
    @means_of_death = MeansOfDeath.new.means_list
    @lines = ReadLog.new(file_path).lines
  end

  def call
    lines.each { |line| parse_line(line) }
    @games.map(&:to_s)
  end

  private

  def parse_line(line)
    if game_start?(line)
      game_name = "game_#{@games.length + 1}"
      @current_game = Game.new(game_name)
    elsif game_over?(line)
      @games.push(@current_game) if @current_game && !@games.include?(@current_game)
    else
      start_fight(line)
    end
  end

  def start_fight(line)
    if player_line?(line)
      player_name = player_name(line)
      @current_game.add_player(player_name)
    elsif kill_event?(line)
      killer, killed, kill_reason = kill_info_from_kill_event(line)
      kill_reason = kill_reason.to_sym
      kill_reason = :MOD_UNKNOWN unless means_of_death.include?(kill_reason)
      @current_game.deal_with_kill_event(killer, killed, kill_reason)
    end
  end
end
