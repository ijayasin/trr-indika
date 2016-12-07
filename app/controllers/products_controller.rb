class ProductsController < ApplicationController
  def index
    slicable_params = %w(availability condition editors_pick on_sale_now with_tags offset limit)
    permitted_params = params.permit(slicable_params)
    opts = Product.with_supported_aggregations({
        :limit  => params[:limit]  || 30,
        :offset => ((params[:page]||1).to_i - 1)* 30
    }).merge(permitted_params)
    @products = Product.where(opts)
  end
end
