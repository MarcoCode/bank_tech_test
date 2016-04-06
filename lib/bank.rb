require_relative "deposit.rb"
require_relative "withdraw.rb"

class Bank 
  attr_reader :choice
  attr_accessor :deposit, :withdraw
  
  def initialize(deposit=Deposit.new, withdraw=Withdraw.new)
    @deposit = deposit
    @withdraw = withdraw
  end
  
  def main_menu
     read_menu
     @amount = gets.chomp
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
    case @amount
     when "1"
       puts "How much would you like to deposit?"
       amount = gets.chomp
       self.deposit = Deposit.new(amount)
     when "2" 
       puts "How much would you like to withdraw?"
       amount = gets.chomp
       self.withdraw = Withdraw.new(amount)
     when "3"
       puts "Here is your statement"
       @choice = gets.chomp
     else
       puts "Please choose 1, 2 or 3"
     end
  end
  
end