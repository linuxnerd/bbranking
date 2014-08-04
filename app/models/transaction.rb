class Transaction < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :invest_type, message: '不能为空'
  validates_presence_of :amount, message: '不能为空'
  validates_presence_of :product_id, message: '不能为空'

  VALID_AMOUNT_REGEX = /\A(([1-9]\d{0,12})|0)(\.\d{1,2})?\z/

  validates :amount, format: { with: VALID_AMOUNT_REGEX, :message => '格式不正确' }

  validates_presence_of :start_date, message: '不能为空', if: ->{ invest_type == 'save' }
  validate :above_balance?, :too_early?

  scope :total_amount, Proc.new { |uid| where(user_id: uid, invest_type: 'save').sum(:amount) - where(user_id: uid, invest_type: 'draw').sum(:amount)}

private
  def above_balance?
    if invest_type == "draw"
      balance = 0
      Transaction.where(user_id: user_id).each do |t|
        if t.invest_type == "save"
          balance += t.amount
        else
          balance -= t.amount
        end
      end

      if balance - amount < 0
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
