class Transaction < ActiveRecord::Base
  belongs_to :user
  belongs_to :category
  belongs_to :account

  delegate :email, to: :user, prefix: true, allow_nil: true
  delegate :name, to: :category, prefix: true, allow_nil: true

  validates_numericality_of :sum
  validates :movement, inclusion: { in: %w(input output)}

  scope :for_inputs, -> { where(movement: "input")}
  scope :for_outputs, -> { where(movement: "output")}
  scope :total_sum, -> (start_date, end_date) {
    where("created_at >= :start_date AND created_at <= :end_date",
          start_date: start_date, end_date: end_date).sum(:sum)
  }
end
