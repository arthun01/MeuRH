class Task < ApplicationRecord
  acts_as_tenant :company
  belongs_to :company
  belongs_to :creator, class_name: 'User'
  
  has_many :task_assignments, dependent: :destroy
  has_many :employees, through: :task_assignments

  enum :status, { not_started: 0, in_progress: 1, completed: 2 }, default: :not_started

  validates :title, presence: true
end
