class Statement
  
  attr_reader :log
  attr_accessor :balance
  
  def initialize(balance=0.0)
    @balance = balance
    @log = []
  end
  
  def back_log
    File.open("./lib/account.txt", "r") do |file|
      while line = file.gets
        puts line
      end
    end
  end
  
  def print
    self.balance = 0.0
    puts "  DATE  ||  CREDIT  || DEBIT || BALANCE  "
    self.log.each do |transaction|
    self.balance += transaction.credit.to_i
    self.balance -= transaction.debit.to_i 
    puts "  #{transaction.date}  ||  #{transaction.credit}  || #{transaction.debit} || #{self.balance}  "
    end
  end
end