class Order < ApplicationRecord
  belongs_to :product
  belongs_to :buyer

  before_save :calculate_total_price

  private

  def calculate_total_price
    self.total_price = product.price * quantity
  end
end
