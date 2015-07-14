class VendingMachine
  VALID_COINS = [
     {name: "nickel", weight: 5, size: 21, value: 5 },
     {name: "dime", weight: 2.2, size: 18, value: 10 },
     {name: "quarter", weight: 5.6, size: 24, value: 25 }
  ]

  def initialize(products)
    @inserted_coins = []
    @coins = []
    @products = products
    @message = nil
    @change = 0
  end

  def insert_coins(coins)
    coins.each do |coin|
      @inserted_coins << coin
    end
  end

  def check_display
    if @message 
      message = @message
      @message = nil
      message
    else
      running_total == 0 ? "INSERT COINS" : to_currency(running_total)
    end
  end

  def select_product(product_name)
    selected_product = @products.find {|product| product[:name] == product_name}
    if !selected_product
      @message = "SOLD OUT"
    else
      dispense_product(selected_product)
    end
  end

  def check_coin_return
    to_currency(@change)
  end

  def return_coins
    amount = running_total
    give_change(amount)
  end

  private 

  def running_total
    @inserted_coins.map {|coin| coin_value(coin) }.reduce(0, &:+)
  end

  def dispense_product(product)
    if can_afford_product?(product)
      amount = running_total - product[:value]
      give_change(amount)
      @message = "THANK YOU"
      product[:name]
    else
      @message = "PRICE #{to_currency(product[:value])}"
      return
    end
  end

  def give_change(amount)
    @change = amount
    @coins += @inserted_coins
    @inserted_coins = []
  end

  def can_afford_product?(product)
    product[:value] <= running_total
  end

  def coin_value(coin)
    coin = VALID_COINS.find do |valid_coin|
      valid_coin[:size] == coin[:size] &&
      valid_coin[:weight] == coin[:weight]
    end
    coin ? coin[:value] : 0
  end

  def to_currency(amount)
    "%.2f" % (amount.to_f / 100)
  end
end
