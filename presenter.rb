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
    table.rows = select_table.map do |category|
      [
        category[:id],
        category[:name],
        sum_amount_of_category(category[:transactions])
      ]
    end
    puts table
  end

  def group_by_categories(categories)
    incomes = []
    expenses = []
    categories.each do |category|
      category[:transaction_type] == "income" ? incomes << category : expenses << category
    end
    { incomes: incomes, expenses: expenses }
  end

  def select_table
    # simula el request categories.index
    file = File.read("./categories.json")
    new_categories = JSON.parse(file, symbolize_names: true)
    new_categories = group_by_categoriesies(new_categories)
    incomes = false # deberia estar en el initialize @incomes
    if incomes
      new_categories[:incomes]
    else
      new_categories[:expenses]
    end
  end
end
