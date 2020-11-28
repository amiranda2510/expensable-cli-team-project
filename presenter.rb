require "terminal-table"
require "date"

module Presenter
  def print_welcome
    puts "####################################"
    puts "#       Welcome to Expensable      #"
    puts "####################################"
  end

  def print_exit
    puts "####################################"
    puts "#    Thanks for using Expensable   #"
    puts "####################################"
  end

  # def gets_option(prompt, options)
  #   puts prompt
  #   print "> "
  #   input = gets.chomp.strip.split
  #   comando = input[0]
  #   until options.include?(comando)
  #     puts "Invalid option"
  #     print "> "
  #     input = gets.chomp.strip
  #   end
  #   input
  # end

  # def gets_option_two(prompt, options)
  #   puts prompt
  #   print "> "
  #   input = gets.chomp.strip.split(" ")
  #   comando = input[0]
  #   until options.include?(comando)
  #     puts "Invalid option"
  #     print "> "
  #     input = gets.chomp.strip
  #   end
  #   input
  # end

  def print_login_message(name, lastname)
    puts
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
end
