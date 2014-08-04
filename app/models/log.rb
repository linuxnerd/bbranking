class Log < ActiveRecord::Base
  belongs_to :product

  scope :latest, -> { where(earning_date: Date.today.prev_day) }
  scope :not_update_yet, -> { where(earning_date: Date.today.prev_day.prev_day) }
  scope :earlist_date, Proc.new { |product_id| where(product_id: product_id).minimum(:earning_date) }
end


