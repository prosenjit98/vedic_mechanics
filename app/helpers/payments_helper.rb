module PaymentsHelper
  def normalize_mobile_number(number, country_code = '91')
    number = number.strip.gsub(/[\s\-\(\)]/, '') # Remove spaces, dashes, etc.
    number.gsub!(/^\+/, '')                     # Remove leading '+'
  
    # Remove leading 0 if present
    number.sub!(/^0+/, '')
  
    if number.length == 10
      number = country_code + number
    elsif number.length > 10 && number.start_with?(country_code)
      # Already includes country code — do nothing
    else
      # Edge case: unknown pattern, still try to add country code
      number = country_code + number
    end
  
    number
  end
end
