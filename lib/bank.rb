class Bank 
  
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
     when "2" 
       puts "How much would you like to withdraw?"
     when "3"
       puts "Here is your statement"
     else
       puts "Please choose 1, 2 or 3"
     end
  end
end