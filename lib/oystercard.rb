
class Oystercard
  attr_reader :balance, :entry_station, :list_of_journeys
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize
    @entry_station = nil
    @balance = 0
    @list_of_journeys = []
  end

  def top_up(amount)
    @amount = amount
    fail "top up of #{@amount} exceeds max limit of #{MAX_BALANCE}" if exceeded?
    @balance += @amount
  end

  def touch_in(station)
    raise 'insufficient funds' if @balance < MIN_CHARGE
    @entry_station = station
    @list_of_journeys.push({@entry_station => ''})
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    @exit_station = station
    @list_of_journeys[0][@entry_station] = @exit_station
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