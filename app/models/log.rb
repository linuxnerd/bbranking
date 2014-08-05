class Log < ActiveRecord::Base
  belongs_to :product

  scope :latest, -> { where(earning_date: Date.today.prev_day) }
  scope :not_update_yet, -> { where(earning_date: Date.today.prev_day.prev_day) }
  scope :earlist_date, Proc.new { |product_id| where(product_id: product_id).minimum(:earning_date) || 0 }

  after_save :calculate_income

  def calculate_income
    User.all.each do |user|
      sum = user.invests.where(product_id: product_id).inject(0) {|sum, el| sum += el.amount}

      if sum > 0
        amount = (sum / 10000 * earning_per_million.to_f).round(2)
        user.incomes.create(
          earning_date: earning_date,
          amount: amount,
          product_id: product_id
        )
      end
    end
  end
end


