class ProductsController < ApplicationController
  def index
    opts = Product.with_supported_aggregations({
        :limit  => params[:limit]  || 30,
        :offset => params[:offset] ||  0
    }).merge(params.to_h.slice(:availability, :editors_pick, :on_sale_now, :with_tags))
    @products = Product.where(opts)
  end
end
