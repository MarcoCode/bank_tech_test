 describe "Feature: deposit" do
   before do 
      @bank = Bank.new
   end
   it "outputs a choice for the user" do
     allow(@bank).to receive(:gets) { "5\n" }
     expect{ @bank.main_menu }.to output("What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\nPlease choose 1, 2 or 3\n").to_stdout
   end
   
   it "Asks the user for amount when 'deposit' is chosen" do
     allow(@bank).to receive(:gets) { "1\n"}
     expect{ @bank.main_menu }.to output("What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\nHow much would you like to deposit?\n").to_stdout
   end
 end