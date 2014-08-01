class Transaction < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :invest_type, message: '不能为空'
  validates_presence_of :amount, message: '不能为空'
  validates_presence_of :product_id, message: '不能为空'

  VALID_AMOUNT_REGEX = /\A(([1-9]\d{0,12})|0)(\.\d{1,2})?\z/

  validates :amount, format: { with: VALID_AMOUNT_REGEX, :message => '格式不正确' }

  validate :above_balance?

private
  def above_balance?
    if invest_type == "draw"
      sum = 0
      Transaction.where(user_id: user_id).each do |t|
        if t.invest_type == "save"
          sum += t.amount
        else
          sum -= t.amount
        end
      end

      if sum < 0
        self.errors.add(:amount, "提现金额不能超过余额")
        false
      end
      true
    end
  end
end
