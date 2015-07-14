class VendingMachine
  VALID_COINS = [
     {weight: 5, size: 21, value: 5 },
     {weight: 2.2, size: 18, value: 10 },
     {weight: 5.6, size: 24, value: 25 }
  ]

  def insert_coins(coins)
    coins_value = coins.reduce(0) do |acc, coin|
       acc += coin_value(coin)
    end
    "%.2f" % (coins_value.to_f / 100)
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
end
