require "terminal-table"

module Presenter
  def print_welcome
    puts "####################################"
    puts "#       Welcome to Expensable      #"
    puts "####################################"
  end

  def print_categories
    incomes = false # deberia estar en el initialize @incomes
    table = Terminal::Table.new
    table.title = incomes ? "Incomes\nNovember 2020" : "Expenses\nNovember 2020"
    table.headings = %w[ID Category Total]
    table.rows = categories_table.map do |category|
      [
        category[:id],
        category[:name],
        sum_amount_of_category(category[:transactions])
      ]
    end
    puts table
  end
end
