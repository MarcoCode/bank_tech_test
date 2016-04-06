 describe "Feature: deposit" do
   before do 
      @bank = Bank.new
      @menu_message = "What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\n"
      @print_layout = "Date        ||  credit   ||  debit   ||    balance\n"
   end
   
   after(:each) do
     File.open("./lib/account.txt", "w") do |file|
       file.write "Date        ||  credit   ||  debit   ||    balance\n"
     end
   end
   
   context "User inputs the wrong choice" do
     it "outputs a choice for the user" do
       allow(@bank).to receive(:gets).and_return("5\n")
       expect{ @bank.main_menu }.to output(@menu_message).to_stdout
       expect(@bank.main_menu).to eq "Please choose 1, 2 or 3"
     end
   end
   
   context "User chooses to deposit" do
     it "Asks the user for amount when 'deposit' is chosen" do
       allow(@bank).to receive(:gets).and_return("1\n", "50\n")
       expect{ @bank.main_menu }.to output(@menu_message+"How much would you like to deposit?\n").to_stdout
       expect(@bank.deposit.amount).to eq 50.0
       expect(@bank.deposit.date).to eq Date.today.strftime
     end
   end
   
   context "User chooses to withdraw" do
     it "Asks the user for amount when 'withdraw' is chosen" do
       allow(@bank).to receive(:gets).and_return("1\n", "50\n", "2\n", "50\n")
       @bank.main_menu
       expect{ @bank.main_menu }.to output(@menu_message+"How much would you like to withdraw?\n").to_stdout
       expect(@bank.withdraw.amount).to eq 50.0
     end
     
     it "Does not allow negative balance" do
       allow(@bank).to receive(:gets).and_return("2\n", "50\n")
       expect{ @bank.main_menu }.to output(@menu_message+"How much would you like to withdraw?\nAmount not available\n").to_stdout
     end
   end
   
   context "User chooses to print the statement" do
     it "prints the statement" do
       allow(@bank).to receive(:gets) { "3\n"}
       expect{ @bank.main_menu }.to output(@menu_message+"Here is your statement\n"+@print_layout).to_stdout
       expect(@bank.statement.print).to eq nil
     end
   end
   
   context "Account:" do
     it "Keeps track of actions performed by the user" do
       allow(@bank).to receive(:gets).and_return("1\n", "50\n")
       @bank.main_menu
       expect{ @bank.statement.print}.to output(@print_layout+"#{Date.today.strftime}  ||   50.0    ||          ||     50.0   \n").to_stdout
     end
     
     it "Correctly subtracts withdrawals from the balance" do
       allow(@bank).to receive(:gets).and_return("1\n", "50\n", "2\n", "20\n")
       @bank.main_menu
       @bank.main_menu
       expect(@bank.balance).to eq 30.0
     end
   end
 end