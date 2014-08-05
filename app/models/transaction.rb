class Transaction < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :invest_type, message: '不能为空'
  validates_presence_of :amount, message: '不能为空'
  validates_presence_of :product_id, message: '不能为空'

  VALID_AMOUNT_REGEX = /\A(([1-9]\d{0,12})|0)(\.\d{1,2})?\z/

  validates :amount, format: { with: VALID_AMOUNT_REGEX, :message => '格式不正确' }

  validates_presence_of :start_date, message: '不能为空', if: ->{ invest_type == 'save' }
  validate :above_balance?, :too_early?

  after_save do
    # 创建一笔交易后
    if invest_type == "save"
      Invest.add_to_account(amount: amount, product_id: product_id, user_id: user_id)
    else
      Invest.minus_from_account(amount: amount, product_id: product_id, user_id: user_id)
    end
  end

private
  def above_balance?
    if invest_type == "draw"
      if Invest.balance(product_id, user_id) - amount < 0
        self.errors.add(:amount, "提现金额不能超过余额")
        return false
      end
      true
    end
  end

  def too_early?
    if invest_type == 'save' && !start_date.blank?
      if start_date < Log.earlist_date(product_id)
        self.errors.add(:start_date, "比数据库记录的日期还要早，您可以选择默认日期")
        return false
      end
    end
    true
  end
end
