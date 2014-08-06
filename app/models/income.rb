class Income < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  scope :total_amount, Proc.new{ |uid| where(user_id: uid).inject(0) {|sum, el| sum += el.amount} }
  
  after_save do
    Invest.add_to_account(amount: amount, product_id: product_id, user_id: user_id)
  end
end
