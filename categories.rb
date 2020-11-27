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
      when "prev" then prev
      end
      print_categories
      action, id = select_menu_expenses_action
    end
  end

  def create_category
    data = category_form

    @categories << CategoriesController.create(@user[:token], data)
  end

  def show_category(_id)
    # para mostrar la tabla de category
    select_menu_show_category
  end

  def update_category(id)
    data = category_form
    category_index = @categories.index { |category| id == category[:id] }
    @categories[category_index] = CategoriesController.update(@user[:token], data, id)
  end

  def delete_category(id)
    # para borrar una categoria
  end

  def add_to(id)
    # para anadir transaction a un category
  end

  def toggle
    @incomes = !@incomes
  end

  def next_table
    # para pasar a la siguiente tabla
  end

  def prev_table
    # para ver tabal previa
  end

  # Load categories
  def load_categories
    @categories = CategoriesController.index(@user[:token])
  end
end
