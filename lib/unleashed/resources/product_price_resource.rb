module Unleashed
  # Resource for the ProductPrices API
  # The Invoices resource allows sales invoices to be listed and viewed.
  # An individual product price can be viewed by appending its identifier
  # (a GUID formatted as XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX) to the URI.
  #
  # @see https://apidocs.unleashedsoftware.com/ProductPrices
  class ProductPriceResource < BaseResource
    def model
      Unleashed::ProductPrice
    end

    # List all product_prices.
    # /ProductPrices - Returns the first 200 product prices because page number 1 is the default.
    def all(options = { Page: 1, PageSize: 200 })
      endpoint = 'ProductPrices'
      params = options.dup

      # Handle Page option
      endpoint << "/#{params[:Page]}" if params[:Page].present?
      response = JSON.parse(@client.get(endpoint, params).body)
      invoices = response.key?('Items') ? response['Items'] : []
      invoices.map { |attributes| Unleashed::ProductPrice.new(@client, attributes) }
    end

    # Get a single product_price
    # /ProductPrices/E6E8163F-6911-40e9-B740-90E5A0A3A996 - Returns details of a particular product_price.
    #
    # @param id [String] product_price ID.
    #
    # @return [Unleashed::ProductPrice]
    def find(id)
      response = JSON.parse(@client.get("ProductPrices/#{id}").body)
      Unleashed::ProductPrice.new(@client, response)
    end

    # Get the first product_price in all
    #
    # @return [Unleashed::ProductPrice]
    def first
      all.first
    end

    # Get a last product_price in all
    #
    # @return [Unleashed::ProductPrice]
    def last
      all.last
    end
  end
end
