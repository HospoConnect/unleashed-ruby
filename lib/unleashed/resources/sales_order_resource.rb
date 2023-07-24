module Unleashed
  # Resource for the SalesOrders API
  # The Invoices resource allows sales invoices to be listed and viewed.
  # An individual sales invoice details can be viewed by appending its identifier
  # (a GUID formatted as XXXXXXXX-XXXX-XXXX-XXXX-XXXXXXXXXXXX) to the URI.
  #
  # @see https://apidocs.unleashedsoftware.com/SalesOrders
  class SalesOrderResource < BaseResource
    def model
      Unleashed::SalesOrder
    end

    def base_endpoint
      'SalesOrders'
    end

    # Create a new sales_order
    def create_or_update(attributes)
      id = attributes[:Guid].present? ? attributes[:Guid] : ''
      endpoint = base_endpoint
      endpoint << "/#{id}" if id.present?
      response = JSON.parse(@client.post(endpoint, attributes).body)
      Unleashed::SalesOrder.new(@client, response)
    end
  end
end
