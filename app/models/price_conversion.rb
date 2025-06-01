class PriceConversion < ApplicationRecord
  validates :currency, presence: true
  validates :rate, presence: true

  def self.update_currency
    puts "\n\n====Job running========="
    url = "#{ENV['EXCHANGE_RATE_API']}"
    begin
      response = HTTParty.get(url)
      data = response.parsed_response
      if data.present?
        puts data
      end
    rescue
      return false
    end
  end
end
