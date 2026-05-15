class CreateEmployees < ActiveRecord::Migration[8.1]
  def change
    create_table :employees do |t|
      t.string :name
      t.string :cpf
      t.integer :age
      t.decimal :bonus_salary, precision: 10, scale: 2
      t.integer :status
      t.references :company, null: false, foreign_key: true
      t.references :role, null: false, foreign_key: true
      t.datetime :discarded_at

      t.timestamps
    end
    add_index :employees, :discarded_at
  end
end
