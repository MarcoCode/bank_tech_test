 describe "Feature: deposit" do
   before do 
      @account = Account.new
      @menu_message = "What would you like to do?\n1 - Deposit\n2 - Withdraw\n3 - Print Statement\n"
      @print_layout = "  DATE  ||  CREDIT  || DEBIT || BALANCE  \n"
   end
   
   after(:each) do
     File.open("./lib/account.txt", "w") do |file|
       file.write "  DATE  ||  CREDIT  || DEBIT || BALANCE  \n"
     end
   end
   
   context "User inputs the wrong choice" do
     it "outputs a choice for the user" do
       allow(@account).to receive(:gets).and_return("5\n")
       expect{ @account.main_menu }.to output(@menu_message).to_stdout
       expect(@account.main_menu).to eq "Please choose 1, 2 or 3"
     end
   end
   
   context "User chooses to deposit" do
     it "Asks the user for amount when 'deposit' is chosen" do
       allow(@account).to receive(:gets).and_return("1\n", "50\n")
       expect{ @account.main_menu }.to output(@menu_message+"How much would you like to deposit?\n").to_stdout
       expect(@account.statement.log[0].credit).to eq "50"
     end
   end
   
   context "User chooses to withdraw" do
     it "Asks the user for amount when 'withdraw' is chosen" do
       allow(@account).to receive(:gets).and_return("1\n", "50\n", "2\n", "50\n")
       @account.main_menu
       expect{ @account.main_menu }.to output(@menu_message+"How much would you like to withdraw?\n").to_stdout
       expect(@account.statement.log[1].debit).to eq "50"
     end
     
     it "Does not allow negative balance" do
       allow(@account).to receive(:gets).and_return("2\n", "50\n")
       expect{ @account.main_menu }.to output(@menu_message+"How much would you like to withdraw?\n").to_stdout
     end
   end
   
   context "User chooses to print the statement" do
     it "prints the statement" do
       allow(@account).to receive(:gets) { "3\n"}
       expect{ @account.main_menu }.to output(@menu_message+"Here is your statement\n"+@print_layout).to_stdout
     end
   end
   
   context "Account:" do
     it "Keeps track of actions performed by the user" do
       allow(@account).to receive(:gets).and_return("1\n", "50\n")
       @account.main_menu
       expect{ @account.statement.print}.to output(@print_layout+"  #{Date.today.strftime}  ||  50  || 0 || 50.0  \n").to_stdout
     end
     
     it "Correctly subtracts withdrawals from the balance" do
       allow(@account).to receive(:gets).and_return("1\n", "50\n", "2\n", "20\n")
       @account.main_menu
       @account.main_menu
       expect(@account.statement.log.length).to eq 2 
     end
     
     it "Stores a log with the transactions made" do
       expect(@account.statement.log).to eq []
     end
   end
 end