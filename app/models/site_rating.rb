class SiteRating < ApplicationRecord
  enum rate: { bad: 1, good: 2, excellent: 3}
end
