# frozen_string_literal: true

RSpec.describe Game do
  let(:game) { described_class.new('game_1') }

  describe '.to_s' do
    let(:expected_response) do
      { 'game_1' => { total_kills: 1, players: %w[test1 test2], kills: { "test1": 1, "test2": 0 },
                      kill_by_reasons: { "MOD_RAILGUN": 1 } } }
    end
    context 'when generate aggregation kill reasons successfully' do
      before { game.deal_with_kill_event('test1', 'test2', 'MOD_RAILGUN') }
      it { expect(game.to_s).to eq(JSON.pretty_generate(expected_response)) }
    end
  end

  describe '.player_by_name' do
    context 'when get player successfully' do
      before { game.deal_with_kill_event('test1', 'test2', 'MOD_RAILGUN') }
      it { expect(game.player_by_name('test1')).to be_truthy }
      it { expect(game.player_by_name('test2')).to be_truthy }
    end

    context 'when get nil when retrieving player by incorrect name' do
      it { expect(game.player_by_name('test3')).to be_nil }
    end
  end

  describe '.deal_with_kill_event' do
    context 'when deal with no suicide kill event successfully' do
      before { game.deal_with_kill_event('test1', 'test2', 'MOD_RAILGUN') }
      let(:player) { game.player_by_name('test1') }
      let(:player2) { game.player_by_name('test2') }

      it { expect(player.kill_times).to eq(1) }
      it { expect(player.was_not_killed_times).to eq(0) }
      it { expect(player.was_killed_times).to eq(0) }

      it { expect(player2.kill_times).to eq(0) }
      it { expect(player2.was_not_killed_times).to eq(1) }
      it { expect(player2.was_killed_times).to eq(0) }
    end

    context 'when deal with kill by <world> event successfully' do
      before do
        game.deal_with_kill_event('<world>', 'test3', 'MOD_TRIGGER_HURT')
      end
      let(:player) { game.player_by_name('test3') }
      it { expect(player.kill_times).to eq(0) }
      it { expect(player.was_not_killed_times).to eq(0) }
      it { expect(player.was_killed_times).to eq(1) }
    end

    context 'when deal with kill by self event successfully' do
      before do
        game.deal_with_kill_event('<world>', 'test4', 'MOD_TRIGGER_HURT')
      end
      let(:player) { game.player_by_name('test4') }
      it { expect(player.kill_times).to eq(0) }
      it { expect(player.was_not_killed_times).to eq(0) }
      it { expect(player.was_killed_times).to eq(1) }
    end
  end
end
