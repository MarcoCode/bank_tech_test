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
    case @choice
     when "1"
       puts "How much would you like to deposit?"
       amount = gets.chomp
       self.deposit = Deposit.new(amount)
       File.open("./lib/account.txt", "a") do |file|
         file.write "#{self.deposit.date}  ||   #{self.deposit.amount}    ||          ||     #{self.balance += self.deposit.amount.to_i}   \n"
       end
     when "2" 
       puts "How much would you like to withdraw?"
       amount = gets.chomp
       self.withdraw = Withdraw.new(amount)
     when "3"
       puts "Here is your statement"
       self.statement.print
     else
       puts "Please choose 1, 2 or 3"
     end
     confirm
  end
  
  def confirm
    if @choice == "1"
      "#{self.deposit.amount} deposited successfully"
    elsif @choice == "2"
      "#{self.withdraw.amount} withdrawn successfully"
    else
      "thank you"
    end
    
  end
  
end