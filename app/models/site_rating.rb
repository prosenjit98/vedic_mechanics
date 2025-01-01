class SiteRating < ApplicationRecord
  enum rate: { bad: 1, good: 2, excellent: 3}
  after_create :send_mail

  def self.rate_percentages
    total_ratings = count.to_f
    return { bad: 0, good: 0, excellent: 0 } if total_ratings.zero?

    rate_counts = group(:rate).count
    rate_counts.transform_values { |count| ((count / total_ratings) * 100).round(2) }
  end

  private

  def send_mail
    ContactMailer.site_comment(self).deliver_later
  end

end
