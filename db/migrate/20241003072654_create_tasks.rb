class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.date :due_date
      t.string :status
      t.references :assigned_to, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
