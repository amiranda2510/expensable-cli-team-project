require_relative "transactions_controller"

module Transactions
  def print_transactions_table(category, date = DateTime.now)
    table = Terminal::Table.new
    table.title = "#{category[:name]}\n#{date.strftime('%B %Y')}" # => Category/nNovember
    table.headings = %w[ID Date Amount Notes]
    rows = []
    category[:transactions].each do |transaction|
      if transaction[:date].match?(/^#{date.strftime("%Y-%m")}/) # => if "2020-12-10" matches /^2020-12/
        transaction_date = DateTime.new(*transaction[:date].split("-").map(&:to_i)) # => "2020-12-12" -> 2020,12,12 eg
        rows << [transaction[:id], transaction_date.strftime("%a, %b %d"), transaction[:amount], transaction[:notes]]
      end
    end
    table.rows = rows
    puts table
  end
end
