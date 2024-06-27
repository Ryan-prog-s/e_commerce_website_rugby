class User < ApplicationRecord
    has_secure_password
    has_one :buyer, dependent: :destroy
    has_one :seller, dependent: :destroy
    after_create :create_buyer_account
  
    private
  
    def create_buyer_account
      Buyer.create(user: self)
    end
  end
  