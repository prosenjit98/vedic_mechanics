class UserReward < ApplicationRecord
  belongs_to :user
  belongs_to :reward

  after_create :update_user_validity

  private

  def update_user_validity
    update(start_date: Date.today, end_date: Date.today + reward.validity)
  end
end
