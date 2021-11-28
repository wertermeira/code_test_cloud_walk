# frozen_string_literal: true

class ReadLog
  attr_reader :log_file

  def initialize(file_path)
    @log_file = File.expand_path(file_path, __FILE__)
  end

  def lines
    read_log
  end

  private

  def read_log
    File.open(log_file, 'r').map { |line| line }
  end
end
