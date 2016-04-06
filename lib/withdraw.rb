class Withdraw
  attr_reader :amount
  def initialize(amount=0)
    @amount = amount.to_f.round(2)
  end
end