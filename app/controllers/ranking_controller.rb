class RankingController < ApplicationController
  def index
    @rankings = []
    @seven_days = {}
    @seven_days_earning = {}

    Product.all.each do |product|
      latest_log = product.logs.order('earning_date desc').first
      earning_date =  Date.today.monday? ? Date.today.prev_day.prev_day.prev_day : Date.today.prev_day
      if latest_log && latest_log.earning_date == earning_date

        @rankings << {
          ranking: latest_log.ranking,
          name: latest_log.product.name,
          money_fund: latest_log.product.money_fund,
          earning_per_million: latest_log.earning_per_million,
          seven_year_yield: latest_log.seven_year_yield,
          scale: latest_log.scale,
          code: latest_log.product.code
        }
      else
        @rankings << {
          ranking: '--',
          name: product.name,
          money_fund: product.money_fund,
          earning_per_million: '--',
          seven_year_yield: '--',
          scale: '--',
          code: latest_log.product.code
        }
      end
      @rankings.sort_by!{ |log| log[:earning_per_million] }.reverse!

      # 7天日期数据
      @seven_days[product.code.to_sym] = []
      @seven_days_earning[product.code.to_sym] = []
      product.logs.where(product_id: product).order("earning_date").limit(7).each do |el|
        @seven_days[product.code.to_sym] << el.earning_date.strftime('%m-%d')
        @seven_days_earning[product.code.to_sym] << el.seven_year_yield.to_f
      end
      
      p @seven_days_earning
      
    end

    

  end
end
