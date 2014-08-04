class TransactionsController < ApplicationController
  before_action :signed_in_user

  def new
    @transaction = Transaction.new
    @default_date = default_start_date
    
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to dashboard_index_path, :flash => { :success=>"成功记录一笔投资" }
    else
      render 'new'
    end
  end

private
  def transaction_params
    params.require(:transaction).permit(:amount, :invest_type, :product_id,
                                        :user_id, :start_date)
  end

  def default_start_date
    if Date.today.tuesday? && Time.now.hour >= 15
      Date.today.next_day.next_day.next_day.next_day
    elsif Date.today.friday?
      Date.today.next_day.next_day.next_day
    elsif Date.today.saturday?
      Date.today.next_day.next_day
    else
      Date.today.next_day
    end
  end
end
