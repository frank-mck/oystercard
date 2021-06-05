
class Oystercard
  attr_reader :balance, :entry_station, :list_of_journeys
  MAX_BALANCE = 90
  MIN_CHARGE = 1

  def initialize
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
    record_entry_station(station)
  end

  def touch_out(station)
    deduct(MIN_CHARGE)
    record_exit_station(station)
  end

  def balance
    @balance
  end

  def has_entry_station
    return false if @list_of_journeys.empty?
    !!print_journeys[-1][:entry_station]
  end

  def in_journey?
    return false if @list_of_journeys.empty?
    !!@list_of_journeys[-1][:entry_station] unless !!@list_of_journeys[-1][:exit_station]
  end

  def print_journeys
    @list_of_journeys.each { |journey| p journey }
  end

 private

  def record_entry_station(station)
    @list_of_journeys.push({ :entry_station => station })
    return station
  end

  def record_exit_station(station)
    @list_of_journeys[-1][:exit_station] = station
  end

  def deduct(amount)
    @balance -= amount
  end

  def exceeded?
    @balance + @amount > MAX_BALANCE
  end
end