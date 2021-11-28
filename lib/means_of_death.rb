# frozen_string_literal: true

class MeansOfDeath
  attr_reader :means_of_death_file

  def initialize(file_path = '../../logs/means_of_death.txt')
    @means_of_death_file = File.expand_path(file_path, __FILE__)
  end

  def means_list
    file_to_array
  end

  private

  def file_to_array
    File.open(means_of_death_file, 'r').map { |line| line.strip.to_sym }
  end
end
