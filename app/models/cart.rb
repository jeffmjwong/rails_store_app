class Cart < ApplicationRecord
  belongs_to :user
  has_many :purchases
end
