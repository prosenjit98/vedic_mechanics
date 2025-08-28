class Admin::RewardsController < Admin::BaseController 
  before_action :set_reward, only: %i[ show edit update destroy ]

  # GET /admin/rewards or /admin/rewards.json
  def index
    @admin_rewards = Reward.all
  end

  # GET /admin/rewards/1 or /admin/rewards/1.json
  def show
  end

  # GET /admin/rewards/new
  def new
    @admin_reward = Reward.new
  end

  # GET /admin/rewards/1/edit
  def edit
  end

  # POST /admin/rewards or /admin/rewards.json
  def create
    @admin_reward = Reward.new(reward_params)

    respond_to do |format|
      if @admin_reward.save
        format.html { redirect_to admin_rewards_url, notice: "Reward was successfully created." }
        format.json { render :show, status: :created, location: @admin_reward }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @admin_reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /admin/rewards/1 or /admin/rewards/1.json
  def update
    respond_to do |format|
      if @admin_reward.update(reward_params)
        format.html { redirect_to admin_rewards_url, notice: "Reward was successfully updated." }
        format.json { render :show, status: :ok, location: @admin_reward }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @admin_reward.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/rewards/1 or /admin/rewards/1.json
  def destroy
    @admin_reward.destroy!

    respond_to do |format|
      format.html { redirect_to admin_rewards_url, notice: "Reward was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def add_users
    @admin_reward = Reward.find(reward_params[:id])
    @selected_users = User.where(id: reward_params[:user_ids])
    @selected_users.each do |user|
      @admin_reward.users << user
    end
    respond_to do |format|
      format.html { redirect_to admin_rewards_url, notice: "Reward was successfully added to the users." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reward
      @admin_reward = Reward.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def reward_params
      params.require(:reward).permit(:id, :name, :description, :validity, :is_active, :points, :image, user_ids: [])
    end
end
