require_relative "transactions.rb"
require_relative "statement.rb"

class Account
  
  attr_reader :statement
  
  def initialize(statement=Statement.new)
    @statement = statement
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
    self.statement.log << Transactions.new(amount, 0)
    "£#{amount} deposited successfully"
  end
  
  def user_withdraw
    puts "How much would you like to withdraw?"
    amount = gets.chomp
    self.statement.log << Transactions.new(0, amount)
    "£#{amount} withdrawn successfully"
  end
  
  def user_statement
    puts "Here is your statement"
    self.statement.print
  end
end