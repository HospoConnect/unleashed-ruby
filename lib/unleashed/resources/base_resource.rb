module Unleashed
  # Base resource for all the other resources to inherit from
  class BaseResource
    def initialize(client)
      @client = client
    end

    def base_endpoint
      raise NotImplementedError
    end

    def method_missing(name, *args, &block)
      if instance_methods.include?(model) && respond_to?(name)
        model.new(@client, id: args[0]).send(name, *args[1..-1])
      else
        super
      end
    end

    def respond_to?(name, include_all = false)
      super || model.new(@client).respond_to?(name, include_all)
    end

    # List all of the model instances.
    # /#{base_endpoint} - Returns the first 200 items because page number 1 is the default.
    def all(options = { Page: 1, PageSize: 200 })
      endpoint = base_endpoint
      params = options.dup

      # Handle Page option
      endpoint << "/#{params[:Page]}" if params[:Page].present?
      response = JSON.parse(@client.get(endpoint, params).body)
      invoices = response.key?('Items') ? response['Items'] : []
      invoices.map { |attributes| model.new(@client, attributes) }
    end

    # Get a single instance of the model
    # /#{base_endpoint}/E6E8163F-6911-40e9-B740-90E5A0A3A996 - Returns details of a particular model.
    #
    # @param id [String]
    #
    # @return model
    def find(id)
      response = JSON.parse(@client.get("#{base_endpoint}/#{id}").body)
      model.new(@client, response)
    end

    # Get the first instance in all
    #
    # @return model
    def first
      all.first
    end

    # Get a last instance in all
    #
    # @return model
    def last
      all.last
    end
  end
end
