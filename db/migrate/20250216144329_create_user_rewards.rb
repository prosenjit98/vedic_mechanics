class CreateUserRewards < ActiveRecord::Migration[7.1]
  def change
    create_table :user_rewards do |t|
      t.integer :user_id
      t.integer :reward_id
      t.datetime :start_date
      t.datetime :end_date

      t.timestamps
    end
  end
end
