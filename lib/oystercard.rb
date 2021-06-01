
class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    @amount = amount
    fail "top up of #{@amount} exceeds max limit of #{MAX_BALANCE}" if exceeded?
    @balance += amount
  end
    
  private

  def exceeded?
    @balance + @amount > MAX_BALANCE
  end
end