module Unleashed
  # Resource for the Products API
  # The Products resource allows products to be listed, viewed, created, and updated.
  # An individual product’s details can be viewed or updated by appending its identifier
  # (a GUID formatted as XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX) to the URI.
  #
  # @see https://apidocs.unleashedsoftware.com/ProductPrices
  class ProductResource < BaseResource
    def model
      Unleashed::Product
    end

    def base_endpoint
      'Products'
    end
  end
end
