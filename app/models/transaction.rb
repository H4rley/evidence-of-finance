class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :account

  delegate :email, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  validates_numericality_of :sum

  scope :for_incomes, -> { where(movement: "input")}
  scope :for_outcomes, -> { where(movement: "output")}
  scope :total_sum, -> (start_date, end_date) {
    where("created_at >= :start_date AND created_at <= :end_date",
          start_date: start_date, end_date: end_date).sum(:sum)
  }
end
