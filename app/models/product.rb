class Product < ActiveRecord::Base
  has_many :logs
  has_many :incomes
  has_many :invests
end
