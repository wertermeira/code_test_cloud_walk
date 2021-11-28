# frozen_string_literal: true

module Utils
  PLAYER_REGEX = /(?<=\\)(.*?)(?=\\)/.freeze
  KILL_REGEX = /Kill:.*:\s(.*)\skilled\s(.*)\sby\s(.*)/.freeze
  GAME_START_REGEX = /InitGame/.freeze
  GAME_END_REGEX = /-----/.freeze

  def game_start?(line)
    line =~ GAME_START_REGEX ? true : false
  end

  def game_over?(line)
    line =~ GAME_END_REGEX ? true : false
  end

  def player_line?(line)
    line =~ PLAYER_REGEX ? true : false
  end

  def player_name(line)
    line =~ PLAYER_REGEX
    Regexp.last_match(1)
  end

  def kill_event?(line)
    line =~ KILL_REGEX ? true : false
  end

  def kill_info_from_kill_event(line)
    line =~ KILL_REGEX
    killer = Regexp.last_match(1)
    killed = Regexp.last_match(2)
    kill_reason = Regexp.last_match(3)
    [killer, killed, kill_reason]
  end
end
