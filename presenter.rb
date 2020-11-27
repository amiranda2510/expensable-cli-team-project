require "terminal-table"
require "date"

module Presenter
  def print_welcome
    puts "####################################"
    puts "#       Welcome to Expensable      #"
    puts "####################################"
  end

  def gets_option(prompt, options)
    puts prompt
    print "> "
    input = gets.chomp.strip

    until options.include?(input)
      puts "Invalid option"
      print "> "
      input = gets.chomp.strip
    end
    input
  end

  def print_welcome_messsage(name, lastname)
    puts "Welcome to Expensable #{name} #{lastname}"
  end
  # PRINT TABLES CATEGORIES

  def print_categories
    month = @date.strftime("%B")
    year = @date.year
    table = Terminal::Table.new
    table.title = @incomes ? "Incomes\n#{month} #{year}" : "Expenses\n#{month} #{year}"
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
    new_categories = group_by_categories(@categories)
    # {incomes:[list_categories], expenses:[list_categories]}
    if @incomes
      new_categories[:incomes]
    else
      new_categories[:expenses]
    end
  end

  def sum_amount_of_category(category)
    sum = 0
    month = @date.month
    year = @date.year
    category.each do |value|
      date_category = DateTime.parse(value[:date])
      sum += value[:amount] if date_category.month == month && date_category.year == year
    end
    sum
  end

  def print_category_table(category, date = DateTime.now)
    table = Terminal::Table.new
    table.title = "#{category[:name]}\n#{date.strftime('%B %Y')}"
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
