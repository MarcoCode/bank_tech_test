 describe "Feature: deposit" do
   
   it "outputs a choice for the user" do
     bank = Bank.new
     allow(bank).to receive(:gets) { "50\n" }
     expect{ bank.deposit }.to output("How much would you like do deposit?\n").to_stdout
   end
 end