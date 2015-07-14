class VendingMachine
  VALID_COINS = [
     {weight: 5, size: 21, value: 5 },
     {weight: 2.2, size: 18, value: 10 },
     {weight: 5.6, size: 24, value: 25 }
  ]
  def initialize
    @running_total = 0
  end

  def insert_coins(coins)
    coins_total = coins.reduce(0) do |acc, coin|
       acc += coin_value(coin)
    end
    @running_total += coins_total
  end

  def check_display
    @running_total == 0 ? "INSERT COINS" : to_currency(@running_total)
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
