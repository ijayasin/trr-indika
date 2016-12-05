require 'rails_helper'

describe ProductsController, type: :controller do

  vcr_options = { :cassette_name => 'all_products_limit_10_offset_0', :record => :new_episodes }
  describe "GET #index" , :vcr => vcr_options do
    # Catch ERb errors, if any.
    render_views

    it "returns http success" do
      get :index
      expect(response).to have_http_status(:success)
    end
  end

end
