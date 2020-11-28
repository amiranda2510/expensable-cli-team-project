require "terminal-table"
require "date"
require "colorize"

class String
  def custom_colorize
    gsub!(/[|>:+#-]/, &:cyan)
    gsub!(/ID|/, &:yellow)
    gsub!(/\b(delete|for|to)\b/, &:light_magenta)
    gsub!(/exit|\b\w*(?=\()|(?<![\[;])\d*(?![m;])/, &:red) # => any number not inside an enclosing eg \e[;0m0m;2]
    self
  end
end

module Presenter
  def print_welcome
    puts "####################################\n"\
         "#       Welcome to Expensable      #\n"\
         "####################################".custom_colorize
  end

  def print_exit
    puts "####################################\n"\
         "#    Thanks for using Expensable   #\n"\
         "####################################".custom_colorize
  end

  def print_login_message(name, lastname)
    puts "Welcome to Expensable #{name} #{lastname}".custom_colorize
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
    puts table.to_s.custom_colorize
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
end
