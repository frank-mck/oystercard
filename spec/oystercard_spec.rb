require 'oystercard'

describe Oystercard do
  let(:max_balance) { Oystercard::MAX_BALANCE }
  let(:station){ double :station }

  it 'has initial balance' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do 
      expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
    end

    it 'expects a default maximum balance on oystercard' do
      expect(max_balance).to eq(90)
    end

    it 'raise error if the top up would take the card obove max limit' do
      subject.top_up(90)
      expect {subject.top_up(1)}.to raise_error("top up of 1 exceeds max limit of #{max_balance}")
    end
  end

  describe '#deducted' do

    it 'is expected to reduce balance by amount given' do
      subject.top_up(20)
      subject.touch_out
      expect(subject.balance).to eq(19)
    end

  describe '#in_journey' do
    it 'is expected to not be in journey' do
      expect(subject.in_journey?).to eq false
    end

    it 'stores the entry station' do
      journey = Oystercard.new
      journey.top_up(22)
      journey.touch_in(station)
      expect(journey.entry_station).to eq station
    end

    it 'can touch in' do
      oyster = Oystercard.new
      oyster.top_up(20)
      oyster.touch_in(station)
      expect(oyster.in_journey?).to eq true
  end

  it 'can touch out' do
    subject.touch_out
    expect(subject.in_journey?).to eq false
  end

  it 'raises error if insufficient funds' do
    expect{ subject.touch_in(station) }.to raise_error('insufficient funds')
  end

  it 'deducts minimum balance when touched out' do
    subject.top_up(10)
    expect {subject.touch_out}.to change{subject.balance}.by(-Oystercard::MIN_CHARGE)
  end
end
end
end