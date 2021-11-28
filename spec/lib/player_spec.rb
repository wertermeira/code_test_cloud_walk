# frozen_string_literal: true

require 'spec_helper'
require 'faker'

RSpec.describe Player do
  let(:player1_name) { Faker::Name.name }
  let(:player1) { described_class.new(player1_name) }
  let(:player2) { described_class.new(Faker::Name.name) }
  let(:player3) { described_class.new('<world>') }
  let(:player4) { described_class.new(Faker::Name.name, 5, 2, 1) }
  let(:player5) { described_class.new(player1_name) }

  describe '.kill' do
    context 'when increase kill times when player kills another player' do
      before { player1.kill(player2) }
      it 'kill_times' do
        expect(player1.kill_times).to eq(1)
      end

      it 'was_not_killed_times' do
        expect(player2.was_not_killed_times).to eq(1)
      end
    end

    context 'when increase was_killed times when player kill himself' do
      before { player1.kill(player1) }
      it { expect(player1.was_killed_times).to eq(1) }
    end

    context  'when increase was_killed times when player is killed by <world>' do
      before { player3.kill(player1) }
      it { expect(player1.was_killed_times).to eq(1) }
    end
  end

  describe '.kills' do
    context 'when kills 0 when player has no kill events' do
      it { expect(player1.kills).to eq(0) }
    end

    context 'when correct kills when player has kill events' do
      it { expect(player4.kills).to eq(4) }
    end
  end

  describe '.==' do
    context 'when comparing same player with himself' do
      it { expect(player1).to eq(player5) }
    end

    context 'when comparing two players' do
      it { expect(player1).not_to eq(player2) }
    end
  end
end
