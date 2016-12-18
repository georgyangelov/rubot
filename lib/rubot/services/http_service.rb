require 'net/http'

module Rubot
  module HttpService
    extend self

    def get_json(url, *args)
      JSON.parse(get(url, *args))
    end

    def get(url, timeout: nil)
      uri = URI.parse(url)

      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
        http.read_timeout = timeout if timeout
        http.get(uri.request_uri)
      end

      return_or_raise_error response
    end

    def post(url, params = {}, timeout: nil)
      uri = URI.parse(url)
      http = Net::HTTP.new(uri.host, uri.port)
      http.read_timeout = timeout if timeout

      req = Net::HTTP::Post.new(uri.path, 'Content-Type' => 'application/json')
      req.body = params.to_json

      response = http.request(req)

      return_or_raise_error response
    end

    private

    def return_or_raise_error(response)
      raise RemoteError, "#{response.code} #{response.body}" if response.code.to_i != 200

      response.body
    end

    class RemoteError < StandardError
    end
  end
end
