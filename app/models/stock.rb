class Stock < ApplicationRecord
  has_many :user_stocks
  has_many :users, through: :user_stocks

  def find_by_ticker(ticker_symbol)
      where(ticker: ticker_symbol).first
  end

  def self.new_from_lookup(ticker_symbol)
    begin
      StockQuote::Stock.new(api_key: "pk_182622b8fe75452f9c72836021fc73e4")
      looked_up_stock = StockQuote::Stock.quote(ticker_symbol)
      new(name: looked_up_stock.company_name, ticker: looked_up_stock.symbol, last_price: looked_up_stock.latest_price)
    rescue Exception => e
      return nil
    end
  end
end
