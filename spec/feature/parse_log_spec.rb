# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ParseLog do
  let(:file_test) { '../../logs/game_test.log' }
  describe '.call' do
    context 'when count games' do
      it { expect(ParseLog.new(file_test).call.count).to eq(3) }
    end

    context 'when hash games' do
      let(:expected_hash) { [a_hash_including('game_1'), a_hash_including('game_2'), a_hash_including('game_3')] }
      it { expect(ParseLog.new(file_test).call).to match(expected_hash) }
    end
  end
end
