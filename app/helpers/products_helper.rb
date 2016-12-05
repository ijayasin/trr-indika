module ProductsHelper

  # "aggregations"=>[
  #   {"type"=>"available", "property"=>"available", "name"=>"Hide sold items", "param"=>"availability", "value"=>"available", "selected"=>false},
  #   {"type"=>"with_tags", "property"=>"with_tags", "name"=>"With Tags",       "param"=>"with_tags",    "value"=>"true",      "selected"=>false}
  # ]
  #
  # http://apidoc.therealreal.com/endpoints/products/index.html
  # http://apidoc.therealreal.com/general/aggregations.html
  #
  def product_aggregations_filters(products, &block) # :yields: name, selected, facet_url
    curr_page = products.current_page
    uri       = URI.parse(curr_page || '/')
    qp        = CGI.parse(uri.query || '')
    %w(aggregations).each{|k| qp.delete(k)}
    qp.delete('offset')
    qp.delete('limit')  if qp['limit']  == ['30']
    new_params = qp.inject({}){|h, (k,v)| h[k] = [v].flatten.first; h }

    products.aggregations.each do |aggr|
      name      = aggr['name']
      param     = aggr['param']
      val       = aggr['value']
      selected  = aggr['selected']

      facet_url = if selected
        new_params2 = new_params.dup
        new_params2.delete(param)
        url_for(new_params2)
      else
        url_for(new_params.merge(param => val))
      end

      yield name, selected, facet_url
    end
  end
end
