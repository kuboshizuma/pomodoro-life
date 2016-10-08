class CreateTodos < ActiveRecord::Migration[5.0]
  def change
    create_table :todos do |t|
      t.string :name
      t.references :weekly_plan
      t.float :hours
      t.integer :priority

      t.timestamps
    end
  end
end
