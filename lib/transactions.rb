require 'date'
class Transactions
  
  attr_reader :credit, :date, :debit, :balance
  
  def initialize(credit=0.0, debit=0.0, date=Date.today.strftime)
    @credit = credit
    @debit = debit
    @date = date
  end
end