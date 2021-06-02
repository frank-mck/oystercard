require 'oystercard'

describe Oystercard do
  let(:max_balance) { Oystercard::MAX_BALANCE }

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
      it { is_expected.to respond_to(:deducted).with(1).argument }

    it 'is expected to reduce balance by amount given' do
      subject.top_up(20)
      expect(subject.deducted(10)).to eq(10)
    end

  describe '#in_journey' do
    it 'is expected to not be in journey' do
      expect(subject.in_journey).to eq false
    end

    it 'can touch in' do
      status = subject.touch_in
      expect(status).to eq true
  end

  it 'can touch out' do
    subject.touch_out
    expect(subject.in_journey).to eq false
  end
end
end
end