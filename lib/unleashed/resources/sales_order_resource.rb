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

    # List all sales_orders.
    # /SalesOrders - Returns the first 200 sales orders because page number 1 is the default.
    def all(options = { Page: 1, PageSize: 200 })
      endpoint = 'SalesOrders'
      params = options.dup

      # Handle Page option
      endpoint << "/#{params[:Page]}" if params[:Page].present?
      response = JSON.parse(@client.get(endpoint, params).body)
      invoices = response.key?('Items') ? response['Items'] : []
      invoices.map { |attributes| Unleashed::Invoice.new(@client, attributes) }
    end

    # Get a single sales_order
    # /SalesOrders/E6E8163F-6911-40e9-B740-90E5A0A3A996 - returns details of a particular invoice.
    #
    # @param id [String] sales order ID.
    #
    # @return [Unleashed::SalesOrder]
    def find(id)
      response = JSON.parse(@client.get("SalesOrders/#{id}").body)
      Unleashed::SalesOrder.new(@client, response)
    end

    # Get a first sales_order in all
    #
    # @return [Unleashed::SalesOrder]
    def first
      all.first
    end

    # Get a last sales_order in all
    #
    # @return [Unleashed::SalesOrder]
    def last
      all.last
    end

    # Create a new sales_order
    def create_or_update(attributes)
      id = attributes[:Guid].present? ? attributes[:Guid] : ''
      endpoint = 'SalesOrders'
      endpoint << "/#{id}" if id.present?
      response = JSON.parse(@client.post(endpoint, attributes).body)
      Unleashed::SalesOrder.new(@client, response)
    end
  end
end
