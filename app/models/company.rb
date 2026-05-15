class Company < ApplicationRecord
  has_many :users, dependent: :destroy
  has_many :roles, dependent: :destroy
  has_many :employees, dependent: :destroy

  validates :name, presence: true
  validates :cnpj, presence: true, uniqueness: true
  validate :cnpj_is_valid

  private

  def cnpj_is_valid
    errors.add(:cnpj, "inválido") if cnpj.present? && !CNPJ.valid?(cnpj)
  end
end
