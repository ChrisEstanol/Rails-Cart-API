class Api::V1::ProductsController < ApplicationController
  before_action :authenticate


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
