module Errplane
  class Transmitter
    def initialize(params = {})
    end

    def relay(black_box)
      http = initialize_http_connection
      data = black_box.to_json
      response = begin
                   url = "/api/v1/applications/#{Errplane.configuration.application_id}/exceptions/#{Errplane.configuration.rails_environment}?api_key=#{Errplane.configuration.api_key}"
                   ::Rails.logger.info(url)
                   http.post("/api/v1/applications/#{Errplane.configuration.application_id}/exceptions/#{Errplane.configuration.rails_environment}?api_key=#{Errplane.configuration.api_key}", data)
                 rescue Exception => e
                   e
                 end
      ::Rails.logger.info("Exception Data: #{data}")
      ::Rails.logger.info("Exception Body: #{response.body}")
      ::Rails.logger.info("Exception Response: #{response.inspect}")

      case response
      when Net::HTTPSuccess
        # Success
      else
        # Failure
      end
    end

    private
    def initialize_http_connection
      connection = Net::HTTP.new(Errplane.configuration.api_host, "80")
    end
  end
end
