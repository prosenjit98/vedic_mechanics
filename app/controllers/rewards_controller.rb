class RewardsController < ApplicationController
  before_action :set_nav_filter

  def index
    @rewards = current_user.user_rewards
  end
  
end