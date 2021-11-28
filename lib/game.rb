# frozen_string_literal: true

require 'json'
require_relative 'kill'
require_relative 'player'

class Game
  attr_reader :game_name, :players, :kills

  def initialize(game_name)
    @game_name = game_name
    @kills = []
    @players = []
  end

  def add_player(player_name)
    player_by_name(player_name) || create_new_player(player_name)
  end

  def deal_with_kill_event(killer, killed, kill_reason)
    killer_player = add_player(killer)
    killed_player = add_player(killed)

    killer_player.kill(killed_player)

    kills.push(Kill.new(killer_player, killed_player, kill_reason))
  end

  def player_by_name(name)
    players.detect { |player| player.name == name }
  end

  def to_s
    JSON.pretty_generate(output_game_hash)
  end

  private

  def output_game_hash
    kills_info = {}
    filter_players.each { |player| kills_info[player.name] = player.kills }
    { game_name => { total_kills: total_kills,
                     players: player_names,
                     kills: kills_info,
                     kill_by_reasons: kill_reasons_hash } }
  end

  def kill_reasons_hash
    kill_reasons = {}
    kills.each do |kill|
      kill_reasons[kill.kill_reason] ||= 0
      kill_reasons[kill.kill_reason] += 1
    end
    kill_reasons
  end

  def player_names
    filter_players.map(&:name)
  end

  def total_kills
    kills.length
  end

  def filter_players
    players.reject { |player| player.name == '<world>' }
  end

  def create_new_player(name)
    player = Player.new(name)
    players.push(player)
    player
  end
end
