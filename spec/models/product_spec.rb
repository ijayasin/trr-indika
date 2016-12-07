require 'rails_helper'

describe Product, type: :model do
  context '#where' do
    vcr_options = { :cassette_name => 'all_products_without_params', :record => :new_episodes }
    context "without filters", :vcr => vcr_options do
      subject{ Product.where }

      it "must contain minimum number of results" do
        expect(subject.size).to eq 30
      end

      it "must return the result count" do
        expect(subject.result_count).to eq 578342
      end

      it "must have a next url" do
        expect(subject.next_url).to eq 'https://api.therealreal.com/v2/products?limit=30&offset=30'
      end
    end


    vcr_options = { :cassette_name => 'all_products_with_limit_30_offset_60', :record => :new_episodes }
    context "with limit 30 offset 60", :vcr => vcr_options do
      subject{ Product.where(:limit => 30, :offset => 60) }

      it "must contain minimum number of results" do
        expect(subject.size).to eq 30
      end

      it "must return the result count" do
        expect(subject.result_count).to eq 578461
      end

      context 'pagination' do
        it "must have a previous url" do
          expect(subject.previous_url).to eq 'https://api.therealreal.com/v2/products?limit=30&offset=30'
        end

        it "must have a current url" do
          expect(subject.current_url).to eq 'https://api.therealreal.com/v2/products?limit=30&offset=60'
        end

        it "must have a next url" do
          expect(subject.next_url).to eq 'https://api.therealreal.com/v2/products?limit=30&offset=90'
        end
      end
    end


    vcr_options = { :cassette_name => 'all_products_with_limit_30_offset_60_and_aggregations', :record => :new_episodes }
    context "with limit 30 offset 60 and aggregation", :vcr => vcr_options do
      subject{ Product.where(Product.with_supported_aggregations(:limit => 30, :offset => 60)) }

      it "must contain minimum number of results" do
        expect(subject.size).to eq 30
      end

      it "must have non-empty aggregations" do
        expect(subject.aggregations).not_to be_empty
      end

      it "must have a next url" do
        expect(subject.next_url).to eq 'https://api.therealreal.com/v2/products?aggregations=available%2Ceditors_pick%2Con_sale_now%2Cwith_tags&limit=30&offset=90'
      end
    end

    vcr_options = { :cassette_name => 'all_products_with_limit_40', :record => :new_episodes }
    context "with limit 40", :vcr => vcr_options do
      subject{ Product.where(:limit => 40) }

      it "must return the result count" do
        expect(subject.result_count).to eq 578342
      end

      it "must have a next url" do
        expect(subject.next_url).to eq 'https://api.therealreal.com/v2/products?limit=40&offset=40'
      end
    end
  end


  vcr_options = { :cassette_name => 'product_with_availability_available', :record => :new_episodes }
  context "when available", :vcr => vcr_options do
    subject{ Product.find(2754027) }

    it "#availability returns a String" do
      expect(subject.sku).to          eq "SON23351"
      expect(subject.availability).to eq "Available"
    end

    it "#price returns a Money object" do
      expect(subject.attributes['price'].value).to      eq "95.0"
      expect(subject.attributes['price'].value.to_f).to eq  95.0
      expect(subject.price).to eq Money.new(9500, 'USD')
    end

    it "#meduim_main_images returns the main images of size " do
      expect(subject.meduim_main_images).to eq [
          "https://product-images2.therealreal.com/SON23351_1_product.jpg",
          "https://product-images2.therealreal.com/SON23351_2_product.jpg",
          "https://product-images2.therealreal.com/SON23351_3_product.jpg",
          "https://product-images2.therealreal.com/SON23351_4_product.jpg",
          "https://product-images2.therealreal.com/SON23351_5_product.jpg",
          "https://product-images2.therealreal.com/SON23351_6_product.jpg"]
    end

    it "#large_main_images returns the main images of size " do
      expect(subject.large_main_images).to eq [
          "https://product-images2.therealreal.com/SON23351_1_enlarged.jpg",
          "https://product-images2.therealreal.com/SON23351_2_enlarged.jpg",
          "https://product-images2.therealreal.com/SON23351_3_enlarged.jpg",
          "https://product-images2.therealreal.com/SON23351_4_enlarged.jpg",
          "https://product-images2.therealreal.com/SON23351_5_enlarged.jpg",
          "https://product-images2.therealreal.com/SON23351_6_enlarged.jpg"]
    end
  end


  vcr_options = { :cassette_name => 'product_with_availability_sold', :record => :new_episodes }
  context "when sold out", :vcr => vcr_options do
    subject{ Product.find(2759947) }

    it "#availability returns a String" do
      expect(subject.sku).to          eq "WRAGB52161"
      expect(subject.availability).to eq "Sold"
    end
  end
end
