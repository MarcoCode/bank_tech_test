describe Statement do
  before do
     @print_layout = "Date        ||  credit   ||  debit   ||    balance\n"
  end
  it "has an initial balance of 0.0" do
    expect(Statement.new.balance).to eq 0.0
  end
  
  it "Has a log property" do
    expect(Statement.new.log).to eq []
  end

end