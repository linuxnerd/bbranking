class Invest < ActiveRecord::Base
  belongs_to :product
  belongs_to :user

  scope :total_amount, Proc.new{ |uid| where(user_id: uid).inject(0) {|sum, el| sum += el.amount} }

  def self.balance(product_id, user_id)
    invest = where(product_id: product_id, user_id: user_id).take
    invest ? invest.amount : 0
  end

  def self.add_to_account(amount: 0, product_id:, user_id:)
    invest = where(product_id: product_id, user_id: user_id).take
    if invest
      invest.update(amount: invest.amount + amount)
    else
      self.create(amount: amount, product_id: product_id, user_id: user_id)
    end
  end

  def self.minus_from_account(amount: 0, product_id:, user_id:)
    invest = self.where(product_id: product_id, user_id: user_id).take
    invest.update(amount: invest.amount - amount)
  end
end
