class CreateTasks < ActiveRecord::Migration[8.1]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :status, default: 0
      t.references :company, null: false, foreign_key: true
      t.string :tags, array: true, default: []
      t.references :creator, null: false, foreign_key: { to_table: :users }

      t.timestamps
    end
  end
end
