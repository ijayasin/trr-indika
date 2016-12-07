# EAGER LOADING
#   Include 	      Type
#   designer 	      Designer
#   artist 	        Artist
#   return_policy 	Return Policy
#   attributes 	    Attribute
#   category 	      Category


unless Rails.env.production?
  require 'net-http-spy'
  Net::HTTP.http_logger_options = {:body => true, :verbose => true}
end


class Product < ActiveResource::Base

  # Product::ProductCollection
  # An instance of this class is returned when you per Product.all, Product.where(...),
  # and Product.find(:all). The constructor has access to the parsed JSON instance.
  class ProductCollection < ActiveResource::Collection
    DEFAULT_LIMIT = 30

    attr_reader :aggregations

    def initialize(parsed = {})
      puts "\n#{'-'*50}\nPARSED:\n#{parsed.inspect}\n#{'-'*50}\n"

      @elements     = parsed['products']
      @aggregations = parsed['aggregations'] || []
      @pagination   = parsed['pagination']   || {}
    end

    def pagination_links
      @pagination['links'] || []
    end

    def current_offset
      @current_offset ||= CGI.parse(URI.parse(current_url||'').query||'').try(:[], "offset").try(:first).to_i
    end

    def current_limit
      @current_limit ||= (CGI.parse(URI.parse(current_url||'').query||'').try(:[], "limit").try(:first)||DEFAULT_LIMIT).to_i
    end
    alias limit_value current_limit  # The limit_value alias is used by Kaminari

    # This method is expected by Kaminari.
    def current_page
      return 0 if current_limit.blank? || current_limit.zero?
      (current_offset / current_limit) + 1
    end

    def total_pages
      return 1 if current_limit.blank? || current_limit.zero?
      (result_count / current_limit) + 1
    end

    def current_url
      @current_url ||= get_pagination_page('self')
    end

    def previous_url
      @previous_url ||= get_pagination_page('prev')
    end

    def next_url
      @next_url ||= get_pagination_page('next')
    end

    def result_count
      @pagination['total']
    end

    protected
    def get_pagination_page(rel)
      nl = pagination_links.select do |link|
        (link || {})['rel'] == rel
      end.first
      return '' unless nl
      nl['href'] || ''
    end
  end

  SUPPORTED_AGGREGATIONS = ['available', 'editors_pick', 'on_sale_now', 'with_tags']

  self.site                   = 'https://api.therealreal.com/v2/'
  self.element_name           = "product"
  self.include_format_in_path = false
  self.collection_parser      = ProductCollection

  self.site = 'https://api.therealreal.com/v2/'
  self.include_format_in_path = false

  headers['Accept-Language'] = 'en'
  headers['Content-Type']    = 'application/vnd.therealreal.v2+json'
  headers['Currency']        = 'USD'

  def availability
    attributes['availability'].try(:name)
  end

  def meduim_main_images
    filtered_images('main', 'medium')
  end

  def large_main_images
    filtered_images('main', 'large')
  end

  def price
    pr = attributes['price']
    Money.new(pr.value.to_f*100, pr.currency)
  end

  def self.with_supported_aggregations(params={})
    {:aggregations => SUPPORTED_AGGREGATIONS.join(',')}.merge(params||{})
  end

  protected
  def filtered_images(rel, size)
    (images || []).select{|img| img.rel == rel}.map do |img|
      img.media.select{|m| m.size == size }.map{|m| m.src }

    end.flatten || []
  end
end

