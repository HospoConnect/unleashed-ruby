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

    def base_endpoint
      'ProductPrices'
    end
  end
end
