# EAGER LOADING
#   Include 	      Type
#   designer 	      Designer
#   artist 	        Artist
#   return_policy 	Return Policy
#   attributes 	    Attribute
#   category 	      Category

class Product < ActiveResource::Base

  # Product::ProductCollection
  class ProductCollection < ActiveResource::Collection
    attr_reader :aggregations

    def initialize(parsed = {})
      puts "\n#{'-'*50}\nPARSED:\n#{parsed.inspect}#{'-'*50}\n"

      @elements  = parsed['products']

      puts "ELEM_SIZE = #{(@elements || []).size}"
      puts "AGGS       is #{parsed['aggregations'].class.name}"
      puts "PAGINATION is #{parsed['pagination'].class.name}"

      @aggregations = parsed['aggregations'] || []
      @pagination   = parsed['pagination']   || {}
    end

    def pagination_links
      @pagination['links'] || []
    end

    def next_page
      @next_page ||= begin
        nl = pagination_links.select do |link|
          (link || {})['rel'] == 'next'
        end.first
        return '' unless nl
        nl['href'] || ''
      end
    end

    def result_count
      @pagination['total']
    end
  end

  self.site                   = 'https://api.therealreal.com/v2/'
  self.element_name           = "product"
  self.include_format_in_path = false
  self.collection_parser      = ProductCollection

  self.site = 'https://api.therealreal.com/v2/'
  self.include_format_in_path = false

  headers['Accept-Language'] = 'en'
  headers['Currency'] = 'USD'

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

  protected
  def filtered_images(rel, size)
    (images || []).select{|img| img.rel == rel}.map do |img|
      img.media.select{|m| m.size == size }.map{|m| m.src }
    end.flatten
  end
end

