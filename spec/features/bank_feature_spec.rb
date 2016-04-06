 describe "Feature: deposit" do
   before do 
      @bank = Bank.new
   end
   
   context "User inputs the wrong choice" do
     it "outputs a choice for the user" do
       allow(@bank).to receive(:gets) { "5\n" }
       expect{ @bank.main_menu }.to output("What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\nPlease choose 1, 2 or 3\n").to_stdout
     end
   end
   
   context "User chooses to deposit" do
     it "Asks the user for amount when 'deposit' is chosen" do
       allow(@bank).to receive(:gets) { "1\n"}
       expect{ @bank.main_menu }.to output("What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\nHow much would you like to deposit?\n").to_stdout
       allow(@bank).to receive(:gets) { "50\n"}
       expect(@bank.deposit.amount).not_to eq 0
     end
   end
   
   context "User chooses to withdraw" do
     it "Asks the user for amount when 'withdraw' is chosen" do
       allow(@bank).to receive(:gets) { "2\n"}
       expect{ @bank.main_menu }.to output("What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\nHow much would you like to withdraw?\n").to_stdout
       allow(@bank).to receive(:gets) { "50\n"}
       expect(@bank.withdraw.amount).not_to eq 0
     end
   end
   
   context "User chooses to print the statement" do
     it "prints the statement" do
       allow(@bank).to receive(:gets) { "3\n"}
       expect{ @bank.main_menu }.to output("What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\nHere is your statement\n").to_stdout
       expect(@bank.statement.print).to eq "No recent transactions"
     end
   end
 end