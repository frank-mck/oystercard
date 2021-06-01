require 'oystercard'

describe Oystercard do
  it 'has initial balance' do
    expect(subject.balance).to eq(0)
  end

  describe '#top_up' do
    it { is_expected.to respond_to(:top_up).with(1).argument }

    it 'can top up the balance' do 
      expect{ subject.top_up(1) }.to change{ subject.balance }.by 1
    end

    it 'expects a default maximum balance on oystercard' do
      max_balance = Oystercard::MAX_BALANCE
      expect(max_balance).to eq(90)
    end

    it 'raise error if the top up would take the card obove max limit' do
      subject.top_up(90)
      expect {subject.top_up(1)}.to raise_error('top up exceeds limit')
    end
  end
end