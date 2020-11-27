require_relative "requester"
require_relative "presenter"
require_relative "categories_controller"

module Categories
  def expenses_menu
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

  def find_by_id(id)
    # para encontrar el category por ID
  end

  def create_category
    # para crear un nuevo category
  end

  def show_category(_id)
    # para mostrar la tabla de category
    select_menu_show_category
  end

  def update_category(id)
    # para actualizar una categoria
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
