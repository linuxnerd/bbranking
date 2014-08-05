class DashboardController < ApplicationController
  def index
    @all_money = []
    @all_income = []
    @income_sum = 0
    Invest.where(user_id: current_user.id).each do |invest|
      product = Product.find(invest.product_id)
      sum = Invest.where(product_id: product.id, user_id: current_user.id).take.amount
      in_sum = Income.where(product_id: product.id, user_id: current_user.id).inject(0) { |sum, el| 
        sum += el.amount
      }
      @all_money << [product.money_fund, sum.to_f] if sum > 0
      @all_income << [product.money_fund, in_sum.to_f] if in_sum > 0
      @income_sum += in_sum
    end
  end
end
