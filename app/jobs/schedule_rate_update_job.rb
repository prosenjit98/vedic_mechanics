class ScheduleRateUpdateJob < ApplicationJob
  queue_as :default

  def perform(*args)
    PriceConversion.update_currency
    ScheduleRateUpdateJob.set(wait: 1.minute).perform_later
  end
end
