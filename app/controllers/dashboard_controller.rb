class DashboardController < ApplicationController
  def index
    @data = [].tap do |d|
      Transaction.select(:product_id).distinct.where(user_id: current_user.id).each do |t|
        product = Product.find(t.product_id)
        sum = Transaction.where(product_id: t.product_id).inject(0) { |sum, el| 
          if el.invest_type == 'save'
            sum += el.amount
          else
            sum -= el.amount
          end
        }
        d << [product.money_fund, sum.to_f] if sum > 0
      end
    end

  end
end
