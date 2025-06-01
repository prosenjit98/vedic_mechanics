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

  task :update_currency => [ :environment ] do
    # CurrencyConversionJob.set(wait_until: Date.tomorrow.beginning_of_day).perform_later
    ScheduleRateUpdateJob.set(wait: 1.minute).perform_later
  end
end