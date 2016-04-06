 describe "Feature: deposit" do
   before do 
      @bank = Bank.new
   end
   
   after(:each) do
     File.open("./lib/account.txt", "w") do |file|
       file.write "Date        ||  credit   ||  debit   ||    balance\n"
     end
   end
   
   context "User inputs the wrong choice" do
     it "outputs a choice for the user" do
       allow(@bank).to receive(:gets) { "5\n" }
       expect{ @bank.main_menu }.to output("What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\nPlease choose 1, 2 or 3\n").to_stdout
     end
   end
   
   context "User chooses to deposit" do
     it "Asks the user for amount when 'deposit' is chosen" do
       allow(@bank).to receive(:gets).and_return("1\n", "50\n")
       expect{ @bank.main_menu }.to output("What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\nHow much would you like to deposit?\n").to_stdout
       expect(@bank.deposit.amount).to eq 50.0
       expect(@bank.deposit.date).to eq Date.today.strftime
     end
   end
   
   context "User chooses to withdraw" do
     it "Asks the user for amount when 'withdraw' is chosen" do
       allow(@bank).to receive(:gets).and_return("2\n", "50\n")
       expect{ @bank.main_menu }.to output("What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\nHow much would you like to withdraw?\n").to_stdout
       expect(@bank.withdraw.amount).to eq 50.0
     end
   end
   
   context "User chooses to print the statement" do
     it "prints the statement" do
       allow(@bank).to receive(:gets) { "3\n"}
       expect{ @bank.main_menu }.to output("What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\nHere is your statement\nDate        ||  credit   ||  debit   ||    balance\n").to_stdout
       expect(@bank.statement.print).to eq nil
     end
   end
   
   context "Account:" do
     it "Keeps track of actions performed by the user" do
       allow(@bank).to receive(:gets).and_return("1\n", "50\n")
       @bank.main_menu
       expect{ @bank.statement.print}.to output("Date        ||  credit   ||  debit   ||    balance\n#{Date.today.strftime}  ||   50.0    ||          ||     50.0   \n").to_stdout
     end
   end
 end