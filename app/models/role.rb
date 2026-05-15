class Role < ApplicationRecord
  belongs_to :company
  acts_as_tenant :company

  has_many :employees, dependent: :restrict_with_error

  validates :title, presence: true
  validates :base_salary, presence: true, numericality: { greater_than_or_equal_to: 0 }
end
