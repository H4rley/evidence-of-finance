class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :account

  delegate :email, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  validates_numericality_of :sum
end
