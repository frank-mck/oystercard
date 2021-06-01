
class Oystercard
  attr_reader :balance
  MAX_BALANCE = 90

  def initialize
    @balance = 0
  end

  def top_up(amount)
    @amount = amount
    fail 'top up exceeds limit' if exceeded?
    @balance += amount
  end
    
  private

  def exceeded?
    @balance + @amount > MAX_BALANCE
  end
end