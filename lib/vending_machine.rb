require_relative 'coin_machine'
class VendingMachine

  def initialize(products)
    @coin_machine = CoinMachine.new
    @products = products
    @message = nil
    @change = []
  end

  def insert_coin(coin)
    @coin_machine.add_coin(coin)
  end

  def check_display
    if @message 
      message = @message
      @message = nil
      message
    else
      @coin_machine.inserted_coins_value == 0 ? "INSERT COINS" : to_currency(@coin_machine.inserted_coins_value)
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
    @change
  end

  def return_coins
    process_change(0)
  end

  private 

  def dispense_product(product)
    if can_afford_product?(product)
      process_change(product[:value])
      @message = "THANK YOU"
      product[:name]
    else
      @message = "PRICE #{to_currency(product[:value])}"
      return
    end
  end

  def process_change(price)
    @change = @coin_machine.pay(price)
  end

  def can_afford_product?(product)
    product[:value] <= @coin_machine.inserted_coins_value
  end

  def to_currency(amount)
    "%.2f" % (amount.to_f / 100)
  end
end
