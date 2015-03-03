class Product < ActiveRecord::Base
  belongs_to :user

  validates :name, :price, :quantity, presence: true
  validates :description, presence: true, length: { maximum: 1000 }
end
