class ProductsController < ApplicationController
  def index
    opts = {
        :limit  => params[:limit]  || 10,
        :offset => params[:offset] ||  0
    }
    @products = Product.all(:params => opts)
  end
end
