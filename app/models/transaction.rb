class Transaction < ActiveRecord::Base
  belongs_to :user

  validates_presence_of :type, message: '不能为空'
  validates_presence_of :amount, message: '不能为空'
end
