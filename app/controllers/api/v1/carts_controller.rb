class Api::V1::CartsController < ApplicationController
  before_action :authenticate
  # Authenticate with token

  def show
    info = $redis.hgetall current_user_cart
    @cart = Cart.new
    info.each do |product_id, quantity|
     @cart.add_item(CartItem.new(product_id, quantity))
    end

    respond_to do |format|
      format.json { render json: @cart }
    end
  end

  def add
    product_id = params[:product_id].to_i
    quantity = params[:quantity].to_i
    $redis.hset current_user_cart, product_id, quantity

    redirect_to product_path(product_id), notice: 'Product has been added to your cart.'
  end

  def remove
    product_id = params[:product_id].to_i
    $redis.hdel current_user_cart, product_id

    redirect_to :back, notice: 'Product has been removed from your cart.'
  end


  private

  def current_user_cart
    "cart#{current_user.id}"
  end

  protected
    def authenticate
      authenticate_token || render_unauthorized
    end

    def authenticate_token
      authenticate_with_http_token do |token, options|
        User.find_by(auth_token: token)
      end
    end

    def render_unauthorized
      self.headers['WWW-Authenticate'] = 'Token realm="Application"'
      render json: 'Wrong authorisation token', status: 401
    end
end
