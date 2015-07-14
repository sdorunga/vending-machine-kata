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
    return unless valid_coin?(coin)

    @inserted_coins << VALID_COINS.find do |valid_coin|
      coins_match?(valid_coin, coin)
    end
  end

  def inserted_coins_value
    @inserted_coins.map {|coin| coin[:value] }.reduce(0, &:+)
  end

  def pay(price)
    paid = inserted_coins_value
    store_inserted_coins
    to_coins(paid - price)
  end

  private

  def store_inserted_coins
    @coins += @inserted_coins
    @inserted_coins = []
  end

  def valid_coin?(coin)
    coin = VALID_COINS.any? do |valid_coin|
      coins_match?(valid_coin, coin)
    end
  end

  def coins_match?(coin, other)
    coin[:size] == other[:size] && coin[:weight] == other[:weight]
  end

  def to_coins(amount)
    [].tap do |change|
      coins_by_value.each do |coin|
        if amount / coin[:value] > 0
          amount -= coin[:value]
          change << coin
        end
      end
    end
  end

  def coins_by_value
    @coins.sort_by { |coin| coin[:value] }.reverse
  end
end
