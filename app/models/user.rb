class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  belongs_to :company
  acts_as_tenant :company
  has_one :employee, dependent: :destroy
  has_many :messages, dependent: :destroy
  
  accepts_nested_attributes_for :company

  validates :name, presence: true
end
