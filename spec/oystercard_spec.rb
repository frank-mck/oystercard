require 'oystercard'

describe Oystercard do
  let(:max_balance) { Oystercard::MAX_BALANCE }
  let(:station){ double :station }
  let(:top_up_touch_in) { double(:top_up_touch_in); subject.top_up(10); subject.touch_in(entry_station)}
  let(:entry_station) { double :entry_station }
  let(:exit_station) { double :exit_station }

  it 'has initial balance' do
    expect(subject.balance).to eq(0)
  end

  it 'expects a default maximum balance on oystercard' do
    expect(max_balance).to eq(90)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do 
      expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
    end

    it 'raise error if the top up would take the card obove max limit' do
      subject.top_up(90)
      expect {subject.top_up(1)}.to raise_error("top up of 1 exceeds max limit of #{max_balance}")
    end
  end

  describe '#touch_in' do
    it 'can touch in' do
      top_up_touch_in
      expect(subject.in_journey?).to eq true
  end
end

  context 'when touching out' do
    describe '#touch_out' do
      it 'can touch out' do
        top_up_touch_in
        subject.touch_out(exit_station)
        expect(subject.in_journey?).to eq false
      end

    it 'is expected to reduce balance by amount given' do
      top_up_touch_in
      subject.touch_out(exit_station)
      expect(subject.balance).to eq(9)
    end

    it 'deducts minimum balance when touched out' do
      top_up_touch_in
      expect {subject.touch_out(exit_station)}.to change{subject.balance}.by(-Oystercard::MIN_CHARGE)
    end
  end

  context '#in_journey' do
    it 'checks to see if list of journeys has an empty list by default' do
      expect(subject.list_of_journeys).to eq []
    end

    it 'is expected to not be in journey' do
      expect(subject.in_journey?).to eq false
    end

    it 'stores the entry station' do
      top_up_touch_in
      expect(subject.entry_station).to eq entry_station
    end

    it 'checks that touching in and out creates one journey' do
      top_up_touch_in
      subject.touch_out(exit_station)
      expect(subject.list_of_journeys).to eq([{entry_station => exit_station}])
    end
end
end
end