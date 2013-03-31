class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :title, :null => false
      t.boolean :completed, :default => false
      t.string :gif
      t.boolean :deleted, :default => false

      t.timestamps
    end
  end
end
