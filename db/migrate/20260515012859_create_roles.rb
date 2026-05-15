class CreateRoles < ActiveRecord::Migration[8.1]
  def change
    create_table :roles do |t|
      t.string :title
      t.decimal :base_salary, precision: 10, scale: 2
      t.references :company, null: false, foreign_key: true

      t.timestamps
    end
  end
end
