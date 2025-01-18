module CategoriesHelper
  def get_parents(category)
    parents = []
    parent = category.parent_category
    while parent.present?
      parents << parent.name
      parent = parent.parent_category
    end
    parents.reverse.join(" > ")
  end

  def get_hierarchy(category)
    categories = []
    categories << category.name
    parent = category.parent_category
    while parent.present?
      categories << parent.name
      parent = parent.parent_category
    end
    categories.reverse.join(" > ")
  end
end
