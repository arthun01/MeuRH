class AddUserToEmployees < ActiveRecord::Migration[8.1]
  def change
    add_reference :employees, :user, null: true, foreign_key: true
  end
end
