describe Bank do
  it "has a deposit property" do
    expect(Bank.new.deposit).to be_an Deposit
  end
  
  it "has a withdraw property" do
    expect(Bank.new.withdraw).to be_an Withdraw
  end
  
  it "has a statement property" do
    expect(Bank.new.statement).to be_an Statement
  end
end