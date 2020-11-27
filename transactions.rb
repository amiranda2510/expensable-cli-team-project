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

  def add_transaction
    transaction_info = transaction_form
    TransactionsController.add_transaction(@user, transaction_info)
  end

  # requester

  def transaction_form
    amount = gets_string("Amount: ")
    date = gets_string("Date: ")  # NEEDS validation for date
    notes = gets_string("Notes: ", required: false)

    { amount: amount, date: date, notes: notes, category_id: @category_id } # NEEDS to create @category_id somewhere
  end
end
