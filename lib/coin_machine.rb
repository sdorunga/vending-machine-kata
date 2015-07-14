class CoinMachine
  VALID_COINS = [
     {name: "nickel", weight: 5, size: 21, value: 5 },
     {name: "dime", weight: 2.2, size: 18, value: 10 },
     {name: "quarter", weight: 5.6, size: 24, value: 25 }
  ]

  def initialize
    @inserted_coins = []
    @coins = [
     {name: "nickel", weight: 5, size: 21, value: 5 },
     {name: "nickel", weight: 5, size: 21, value: 5 },
     {name: "dime", weight: 2.2, size: 18, value: 10 },
     {name: "dime", weight: 2.2, size: 18, value: 10 },
     {name: "quarter", weight: 5.6, size: 24, value: 25 },
     {name: "quarter", weight: 5.6, size: 24, value: 25 }
    ]
  end

  def add_coin(coin)
    @inserted_coins << coin
  end

  def inserted_coins_value
    @inserted_coins.map {|coin| coin_value(coin) }.reduce(0, &:+)
  end

  def pay(price)
    paid = inserted_coins_value
    @coins += @inserted_coins
    @inserted_coins = []
    to_coins(paid - price)
  end

  private

  def coin_value(coin)
    coin = VALID_COINS.find do |valid_coin|
      coins_match?(valid_coin, coin)
    end
    coin ? coin[:value] : 0
  end

  def coins_match?(coin, other)
    coin[:size] == other[:size] && coin[:weight] == other[:weight]
  end

  def to_coins(amount)
    sorted_coins = @coins.sort_by { |coin| coin_value(coin) }.reverse
    change = []
    while !sorted_coins.empty?
      coin = sorted_coins.first
      if coin[:value]
        if amount / coin[:value] > 0
          amount -= coin[:value]
          change << coin
        end
      end
      sorted_coins.shift 
    end
    #if amount == 0 
      change 
    #else
    #  @message = "EXACT CHANGE ONLY"
    #  []
    #end
  end


  def to_currency(amount)
    "%.2f" % (amount.to_f / 100)
  end
end
