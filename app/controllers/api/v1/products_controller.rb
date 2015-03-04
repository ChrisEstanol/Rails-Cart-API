class Api::V1::ProductsController < ApplicationController
  before_action :auth_access

  respond_to :json

    def index
      respond_with Product.all
    end

    def show
      respond_with Product.find(params[:id])
    end

    def create
      respond_with Product.create(params[:product])
    end

    def update
      respond_with Product.update(params[:id], params[:product])
    end

    def destroy
      respond_with Product.destroy(params[:id])
    end

  private
    def auth_access
      api_key = User.find_by_auth_token(params[:auth_token])
      head :unauthorized unless api_key
    end

end
