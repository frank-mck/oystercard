
class Oystercard
  attr_reader :balance, :entry_station
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize
    @entry_station = nil
    @balance = 0
  end

  def top_up(amount)
    @amount = amount
    fail "top up of #{@amount} exceeds max limit of #{MAX_BALANCE}" if exceeded?
    @balance += amount
  end

  def touch_in(station)
    raise 'insufficient funds' if @balance < MIN_CHARGE
    @entry_station = station
  end

  def touch_out
    deduct(MIN_CHARGE)
    @entry_station = nil
  end

  def in_journey?
    !!entry_station
  end

  private

  def deduct(amount)
    @balance -= amount
  end

  def exceeded?
    @balance + @amount > MAX_BALANCE
  end
end