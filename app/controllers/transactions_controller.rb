class TransactionsController < ApplicationController
  before_action :signed_in_user

  def new
    @transaction = Transaction.new
  end

  def create
    @transaction = Transaction.new(transaction_params)
    if @transaction.save
      redirect_to root_path, :flash => { :success=>"成功记录一笔投资" }
    else
      render 'new'
    end
  end

private
  def transaction_params
    params.require(:transaction).permit(:amount, :type, :product_id, :user_id)
  end
end
