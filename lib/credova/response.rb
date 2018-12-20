module Credova
  class Response

    def initialize(response)
      @response = response

      case @response
      when Net::HTTPOK, Net::HTTPSuccess
        @data = JSON.parse(@response.body).deep_symbolize_keys
      when Net::HTTPUnauthorized
        raise Credova::Error::NotAuthorized.new(@response.body)
      when Net::HTTPNotFound
        raise Credova::Error::NotFound.new(@response.body)
      when Net::HTTPNoContent
        raise Credova::Error::NoContent.new(@response.body)
      else
        raise Credova::Error::RequestError.new(@response.body)
      end
    end

    def [](key)
      @data[key]
    end

    def body
      @data
    end

    def fetch(key)
      @data.fetch(key)
    end

  end
end
