class Category < ActiveRecord::Base
  has_many :transactions

  def total_incomes(start_date, end_date)
    transactions.for_incomes.total_sum(start_date, end_date)
  end

  def total_outcomes(start_date, end_date)
    transactions.for_outcomes.total_sum(start_date, end_date)
  end

end
