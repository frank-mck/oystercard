
class Oystercard
  attr_reader :balance, :in_journey
  MAX_BALANCE = 90

  def initialize
    @in_journey = false
    @balance = 0
  end

  def top_up(amount)
    @amount = amount
    fail "top up of #{@amount} exceeds max limit of #{MAX_BALANCE}" if exceeded?
    @balance += amount
  end
    
  def deducted(amount)
    @balance -= amount
  end

  def touch_in
    @in_journey = true
  end

  def touch_out
    @in_journey = false
  end
  
  private

  def exceeded?
    @balance + @amount > MAX_BALANCE
  end
end