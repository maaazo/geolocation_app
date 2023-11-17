# frozen_string_literal: true

# GeolocationProviderService interacts with the IPStack API
# to obtain geolocation data for a given IP address.
class GeolocationProviderService
  URL = 'http://api.ipstack.com'

  def lookup(ip)
    response = Faraday.get("#{URL}/#{ip}/?access_key=#{ENV['ACCESS_KEY']}")

    if response.success?
      JSON.parse(response.body)
    else
      handle_error(response)
    end
  rescue JSON::ParserError => e
    handle_error(response, e.message)
  end

  private

  def handle_error(response)
    error_message = "Request to IPStack API failed with status #{response.status}"
    raise error_message.to_s
  end
end
