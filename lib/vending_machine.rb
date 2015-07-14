class VendingMachine
  VALID_COINS = [
     {name: "nickel", weight: 5, size: 21, value: 5 },
     {name: "dime", weight: 2.2, size: 18, value: 10 },
     {name: "quarter", weight: 5.6, size: 24, value: 25 }
  ]

  def initialize(products)
    @products = products
    @running_total = 0
    @message = nil
    @change = 0
  end

  def insert_coins(coins)
    coins_total = coins.reduce(0) do |acc, coin|
       acc += coin_value(coin)
    end
    @running_total += coins_total
  end

  def check_display
    if @message 
      message = @message
      @message = nil
      message
    else
      @running_total == 0 ? "INSERT COINS" : to_currency(@running_total)
    end
  end

  def select_product(product_name)
    selected_product = @products.find {|product| product[:name] == product_name}
    if selected_product
      if selected_product[:value] <= @running_total
        @message = "THANK YOU"
        @change = @running_total - selected_product[:value]
        @running_total -= selected_product[:value]
        selected_product[:name]
      else
        @message = "PRICE #{to_currency(selected_product[:value])}"
        return
      end
    else
      @message = "SOLD OUT"
    end
  end

  def check_coin_return
    to_currency(@change)
  end

  def return_coins
    @change = @running_total
    @running_total = 0
  end

  private 

  def coin_value(coin)
    coin = VALID_COINS.find do |valid_coin|
      valid_coin[:size] == coin[:size] &&
      valid_coin[:weight] == coin[:weight]
    end
    return 0 unless coin
    coin[:value]
  end

  def to_currency(amount)
    "%.2f" % (amount.to_f / 100)
  end
end
