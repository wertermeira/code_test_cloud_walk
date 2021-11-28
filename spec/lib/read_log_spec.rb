# frozen_string_literal: true

require 'spec_helper'

RSpec.describe ReadLog do
  let(:file_test) { '../../logs/game_test.log' }
  describe '.call' do
    context 'when count lines' do
      it { expect(described_class.new(file_test).lines.count).to eq(158) }
    end
  end
end
