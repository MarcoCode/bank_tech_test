class Statement
  def print
    File.open("./lib/account.txt", "r") do |file|
      while line = file.gets
        puts line
      end
    end
  end
end