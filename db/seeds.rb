# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

if Product.where(code: "000343").blank?
  Product.create(
    name: "微信理财通",
    money_fund: "华夏财富宝货币",
    url: "http://www.chinaamc.com/yingxiao/2013/caifubao/index.html?WT.mc_id=baidu_caifubao064&creative=1878748888&WT.srch=1",
    code: "000343"
  )
end

if Product.where(code: "000198").blank?
  Product.create(
    name: "余额宝",
    money_fund: "天弘增利宝货币",
    url: "https://financeprod.alipay.com/fund/index.htm",
    code: "000198"
  )
end

if Product.where(code: "000464").blank?
  Product.create(
    name: "百度百赚利滚利版",
    money_fund: "嘉实活期宝货币",
    url: "http://8.baidu.com/product/0/detail/0?item_id=4",
    code: "000464"
  )
end

if Product.where(code: "000607").blank?
  Product.create(
    name: "招商银行朝朝盈",
    money_fund: "招商招财宝货币B",
    url: "#",
    code: "000607"
  )
end

if Product.where(code: "202301").blank?
  Product.create(
    name: "现金宝",
    money_fund: "南方现金增利货币A",
    url: "http://www.nffund.com/main/campaign/sssh/index.html",
    code: "202301"
  )
end

if User.where(email: "admin@g.com").blank?
  User.create(
    email: "admin@g.com",
    name: "Admin",
    password: "qwe123",
    password_confirmation: "qwe123",
    role: "admin"
  )
end
