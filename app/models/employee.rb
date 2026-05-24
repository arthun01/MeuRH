class Employee < ApplicationRecord
  include Discard::Model

  belongs_to :company
  acts_as_tenant :company
  belongs_to :role
  belongs_to :user, optional: true

  has_many :task_assignments, dependent: :destroy
  has_many :tasks, through: :task_assignments

  accepts_nested_attributes_for :user, reject_if: proc { |attributes| attributes['email'].blank? && attributes['password'].blank? }

  enum :status, { em_servico: 0, almoco: 1, fora_de_servico: 2, de_folga: 3 }, default: :fora_de_servico

  validates :name, presence: true
  validates :cpf, presence: true, uniqueness: { scope: :company_id }

  after_update_commit -> {
    # Update for Admins
    broadcast_replace_to "company_#{self.company_id}_admin_employees",
                         target: "employee_#{self.id}_row",
                         partial: "employees/employee_row",
                         locals: { employee: self, is_admin: true, is_own_row: false }
    
    # Update for Common Colleagues
    broadcast_replace_to "company_#{self.company_id}_common_employees",
                         target: "employee_#{self.id}_row",
                         partial: "employees/employee_row",
                         locals: { employee: self, is_admin: false, is_own_row: false }

    # Update for the Employee who owns the row
    broadcast_replace_to "employee_#{self.id}_updates",
                         target: "employee_#{self.id}_row",
                         partial: "employees/employee_row",
                         locals: { employee: self, is_admin: false, is_own_row: true }
  }

  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 14 }
  validates :bonus_salary, numericality: { greater_than_or_equal_to: 0 }
  validate :cpf_is_valid

  delegate :base_salary, to: :role, prefix: true, allow_nil: true

  def total_salary
    (role_base_salary || 0.0) + (bonus_salary || 0.0)
  end

  private

  def cpf_is_valid
    errors.add(:cpf, "inválido") if cpf.present? && !CPF.valid?(cpf)
  end
end
