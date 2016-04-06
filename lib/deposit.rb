require 'date'
class Deposit
  
  attr_reader :amount, :date
  
  def initialize(amount=0, date=Date.today.strftime)
    @amount = amount.to_f.round(2)
    @date = date
  end
end