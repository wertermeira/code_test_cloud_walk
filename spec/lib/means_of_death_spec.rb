require 'spec_helper'

RSpec.describe MeansOfDeath do
  let(:means_of_death) { described_class.new.means_list }
  describe '.means_list' do
    File.open(File.expand_path('../../../logs/means_of_death.txt', __FILE__), 'r').each_line do |line|
      context " when include mean #{line.strip}" do
        it { expect(means_of_death).to include(line.strip.to_sym) }
      end
    end
  end
end