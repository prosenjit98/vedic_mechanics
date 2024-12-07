namespace :category do
  task :update_position => [ :environment ] do
    categories = Category.order(:created_at).group_by(&:parent_category_id)
    categories.each do |parent, categories|
      position = 1
      categories.each do |cat|
        cat.update(position: position)
        position += 1
      end
    end
  end
end