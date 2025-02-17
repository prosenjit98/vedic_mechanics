class Reward < ApplicationRecord
  has_many :user_rewards
  has_many :users, through: :user_rewards
end
