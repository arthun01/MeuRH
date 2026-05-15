class Message < ApplicationRecord
  belongs_to :user
  belongs_to :company
  acts_as_tenant :company

  validates :content, presence: true

  after_create_commit -> {
    broadcast_append_to "company_#{self.company_id}_chat",
                        target: "messages",
                        partial: "messages/message",
                        locals: { message: self }
  }
end
