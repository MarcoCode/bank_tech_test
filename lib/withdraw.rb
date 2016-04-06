class Withdraw
  attr_reader :amount
  def initialize(amount=0)
    @amount = amount
  end
end