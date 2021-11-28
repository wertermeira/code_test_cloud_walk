# frozen_string_literal: true

RSpec.describe Utils do
  let(:extended_class) { Class.new { extend Utils } }

  describe '.game_start?' do
    context 'when return true' do
      let(:line) { '0:00 InitGame:' }
      it { expect(extended_class.game_start?(line)).to be true }
    end

    context 'when return true' do
      let(:line) { '0:00 ClientConnect: 2' }
      it { expect(extended_class.game_start?(line)).to be false }
    end
  end

  describe '.game_over?' do
    context 'when return true' do
      let(:line) { ' 11:00 ------------------------------------------------------------' }
      it { expect(extended_class.game_over?(line)).to be true }
    end

    context 'when return false' do
      let(:line) { '11:01 ClientConnect: 2' }
      it { expect(extended_class.game_over?(line)).to be false }
    end
  end

  describe '.player_line?' do
    context 'when return true' do
      let(:line) { '21:51 ClientUserinfoChanged: 3 n\Dono da Bola\t\0\model\sarge/' }
      it { expect(extended_class.player_line?(line)).to be true }
    end

    context 'when return false' do
      let(:line) { '11:01 ClientConnect: 2' }
      it { expect(extended_class.player_line?(line)).to be false }
    end
  end

  describe '.player_name' do
    context 'when parse the kill event successfully' do
      let(:line) do
        '21:51 ClientUserinfoChanged: 3 n\Isgalamido\t\0\model\xian/default\hmodel\xia'
      end
      it { expect(extended_class.player_name(line)).to eq('Isgalamido') }
    end
  end

  describe '.kill_event?' do
    context 'when return true' do
      let(:line) { '21:51 Kill: 1022 0 9: Isgalamido killed Dono da Bola by MOD_TRIGGER_HURT' }
      it { expect(extended_class.kill_event?(line)).to be true }
    end

    context 'when return false' do
      let(:line) { 'Item: 3 weapon_railgun' }
      it { expect(extended_class.kill_event?(line)).to be false }
    end
  end

  describe '.kill_info_from_kill_event' do
    let(:line) { '21:51 Kill: 1022 0 9: Isgalamido killed Dono da Bola by MOD_TRIGGER_HURT' }
    context 'when event successfully' do
      it 'killer' do
        expect(extended_class.kill_info_from_kill_event(line)[0]).to eq('Isgalamido')
      end

      it 'killed' do
        expect(extended_class.kill_info_from_kill_event(line)[1]).to eq('Dono da Bola')
      end

      it 'weapon' do
        expect(extended_class.kill_info_from_kill_event(line)[2]).to eq('MOD_TRIGGER_HURT')
      end
    end
  end
end
