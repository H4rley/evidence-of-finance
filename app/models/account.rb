class Account < ActiveRecord::Base
  has_many :transactions

  validates :sum, :critical_amount, presence: true
  validates_numericality_of :sum
end
