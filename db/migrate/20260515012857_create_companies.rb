class CreateCompanies < ActiveRecord::Migration[8.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :cnpj
      t.boolean :active

      t.timestamps
    end
  end
end
