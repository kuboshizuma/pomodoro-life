class CreateWeeklyPlans < ActiveRecord::Migration[5.0]
  def change
    create_table :weekly_plans do |t|
      t.datetime :start_date
      t.references :user

      t.timestamps
    end
  end
end
