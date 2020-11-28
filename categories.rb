require_relative "requester"
require_relative "presenter"
require_relative "categories_controller"

module Categories
  def categories
    load_categories
    print_categories
    action, id = select_menu_expenses_action
    until action == "logout"
      case action
      when "create" then create_category
      when "show" then show_category(id.to_i)
      when "update" then update_category(id.to_i)
      when "delete" then delete_category(id.to_i)
      when "add-to" then add_to(id.to_i)
      when "toggle" then toggle
      when "next" then next_table
      when "prev" then prev_table
      end
      print_categories
      action, id = select_menu_expenses_action
    end
  end

  def create_category
    data = category_form

    @categories << CategoriesController.create(@user[:token], data)
  end

  def show_category(id)
    # this is created so some methods in Transactions and TransactionsController have access to the category id
    @category_id = id
    loop do
      # NEEDS rescue if category couldn't be found
      print_transactions_table(id, @date)
      input = select_transaction_option
      break if input.first == "back"

      begin
        execute_option(*input) # input may be [option] or [option, id]
      rescue Net::HTTPError => e
        puts "\n\n#{e}\n\n".red
      end
    end
  end

  def update_category(id)
    data = category_form
    category_index = @categories.index { |category| id == category[:id] }
    @categories[category_index] = CategoriesController.update(@user[:token], data, id)
  end

  def delete_category(id)
    @categories.reject! { |category| category[:id] == id }
    CategoriesController.destroy(id, @user[:token])
  end

  def add_to(id)
    # para anadir transaction a un category
  end

  def toggle
    @incomes = !@incomes
  end

  def next_table
    @date = @date.next_month
  end

  def prev_table
    @date = @date.prev_month
  end

  # Load categories
  def load_categories
    @categories = CategoriesController.index(@user[:token])
  end
end
