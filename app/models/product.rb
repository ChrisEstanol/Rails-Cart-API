class Product < ActiveRecord::Base
  belongs_to :user

  validates :name, :price, :quantity, presence: true
  validates :description, presence: true, length: { maximum: 1000 }

  def in_cart?(current_user_id)
    $redis.hexists "cart#{current_user_id}", id
  end

  def cart_quantity
    $redis.hget "cart#{current_user_id}", id
  end
end
