class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :priority
      t.datetime :deadline
      t.boolean :complete
      t.integer :duration
      t.boolean :favorite

      t.timestamps null: false
    end
  end
end
