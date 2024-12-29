module ProductsHelper
  def breadcrumb(items)
    content_tag(:nav, class: "flex", aria: { label: "Breadcrumb" }) do
      content_tag(:ol, class: "inline-flex items-center space-x-1 md:space-x-2 rtl:space-x-reverse") do
        items.each_with_index.map do |item, index|
          breadcrumb_item(item, index, items.size)
        end.join.html_safe
      end
    end
  end

  def categories_breadcrumb(category_id)
    category = Category.find_by(id: category_id)
    items = []
    if category.present?
      until category.nil?
        items << { name: category.name, url: "" }
        category = category.parent_category
      end
    end
    breadcrumb(items.reverse)
  end

  def generate_description product
    content_tag(:div) do
      content_tag(:div, product.description) + product_description(product)
    end
  end

  def generate_specification product
    content_tag(:div) do
      content_tag(:div, product.specification.to_s) + ingredients(product)
    end
  end

  private

  def product_description product
    ingredients = Ingredient.where(name: product.product_code)
    content_tag(:div) do
      if ingredients.present?
        ingredients.map do |ingredient|
          content_tag(:div, ingredient.description.to_s)
        end.join.html_safe
      end
    end
  end

  def ingredients(product)
    content_tag(:div) do
      if product.ingredients.present?
        content_tag(:h3, "About ingredients: ", class: "font-semibold text-lg mt-2") + 
        product.ingredients.map do |ingredient|
          content_tag(:div, ingredient.description.to_s)
        end.join.html_safe
      end
    end
  end

  def breadcrumb_item(item, index, total_items)
    if index == total_items - 1
      # Last item, no link
      content_tag(:li, aria: { current: "page" }) do
        content_tag(:div, class: "flex items-center") do
          arrow_svg + content_tag(:span, item[:name].humanize, class: "ms-1 text-md font-medium text-gray-500 md:ms-2 dark:text-gray-400")
        end
      end
    else
      # Intermediate items, with link
      content_tag(:li) do
        content_tag(:div, class: "flex items-center") do
          arrow_svg + link_to(item[:name].humanize, item[:url], class: "ms-1 text-md font-medium text-gray-700 hover:text-blue-600 md:ms-2 dark:text-gray-400 dark:hover:text-white")
        end
      end
    end
  end

  def arrow_svg
    content_tag(:svg, class: "rtl:rotate-180 w-3 h-3 text-gray-400 mx-1", aria: { hidden: "true" }, xmlns: "http://www.w3.org/2000/svg", fill: "none", viewBox: "0 0 6 10") do
      content_tag(:path, "", stroke: "currentColor", stroke_linecap: "round", stroke_linejoin: "round", stroke_width: "2", d: "m1 9 4-4-4-4")
    end
  end
end
