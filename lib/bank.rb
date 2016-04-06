require_relative "deposit.rb"
require_relative "withdraw.rb"
require_relative "statement.rb"

class Bank 
  attr_reader :choice
  attr_accessor :deposit, :withdraw, :statement, :balance
  
  def initialize(deposit=Deposit.new, withdraw=Withdraw.new, statement=Statement.new, balance=0.0)
    @deposit = deposit
    @withdraw = withdraw
    @statement = statement
    @balance = balance
    user_account
  end
  
  def main_menu
     read_menu
     @choice = gets.chomp
     display_action
  end
  
  private
  def read_menu 
    File.open("./lib/menu.txt", "r") do |file|
      while line = file.gets
        puts line
      end
    end
  end
  
  def display_action
    user_deposit if @choice == "1"
    user_withdraw if @choice == "2"
    user_statement if @choice == "3"
    "Please choose 1, 2 or 3" if !["1", "2", "3"].include?(@choice)
  end
  
  def user_deposit
    puts "How much would you like to deposit?"
    amount = gets.chomp
    self.deposit = Deposit.new(amount)
    File.open("./lib/account.txt", "a") do |file|
      file.write "#{self.deposit.date}  ||   #{self.deposit.amount}    ||          ||     #{self.balance += self.deposit.amount.to_i}   \n"
    end
    "£#{self.deposit.amount} deposited successfully"
  end
  
  def user_withdraw
    puts "How much would you like to withdraw?"
    amount = gets.chomp
    self.withdraw = Withdraw.new(amount)
    return insufficient_funds if self.withdraw.amount > self.balance
    File.open("./lib/account.txt", "a") do |file|
      file.write "#{self.withdraw.date}  ||           ||     #{self.withdraw.amount} ||     #{self.balance -= self.withdraw.amount.to_i}   \n"
    end
    "£#{self.withdraw.amount} withdrawn successfully"
  end
  
  def user_statement
    puts "Here is your statement"
    self.statement.print
  end
  
  def insufficient_funds
    puts "Amount not available"
  end
  
  def user_account
    File.open("./lib/account.txt", "w") do |file|
      file.write "Date        ||  credit   ||  debit   ||    balance\n"
    end
  end
  
end