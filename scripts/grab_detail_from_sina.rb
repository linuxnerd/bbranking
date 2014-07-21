require "open-uri"
require "nokogiri"

Product.all.each do |product|
  url = "http://finance.sina.com.cn/fund/quotes/" + 
        product.code + 
        "/bc.shtml"
  page = Nokogiri::HTML(open(url))

  # 净值更新日期
  updated_date = page.css('#box-hq tr th .date').text
  #earning_date =  Date.today.monday? ? Date.today.prev_day.prev_day.prev_day : Date.today.prev_day
  next if updated_date.to_date != Date.today.prev_day

  # 最新规模
  scale = page.css('#box-hq tr th .scale').text

  # 七日年化利率
  seven_year_yield = page.css('#table-fund-performance-rank tbody tr').first.css('td').first.text.strip
  
  # 万份收益
  earning_per_million = page.css('#table-fund-performance-rank tbody tr')[2].css('td').first.text.strip
  
  # 增减
  ranking = '-'
  if yesterday_log = Log.where(product_id: product.id, earning_date: Date.today.prev_day.prev_day).take
    case 
    when earning_per_million.to_f > yesterday_log.earning_per_million.to_f
      ranking = 'up'
    when earning_per_million.to_f < yesterday_log.earning_per_million.to_f
      ranking = 'down'
    end
  end

  if Log.where(earning_date: updated_date, product_id: product.id).take.nil?
    Log.create!(
      earning_date: updated_date,
      seven_year_yield: seven_year_yield,
      earning_per_million: earning_per_million,
      scale: scale,
      ranking: ranking,
      product_id: product.id
    )
  end

end