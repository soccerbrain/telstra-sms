require 'json'
require 'httparty'
require "telstra/sms/version"

module Telstra
  class SMS

    attr_accessor :api_key, :api_secret, :token
    
    # Initialize API Keys
    def initialize(api_key, api_secret)
      @api_key = api_key
      @api_secret = api_secret
    end

    # OAuth 2.0 Token. This will expire every hour.
    def generate_token
      response = HTTParty.get("https://api.telstra.com/v1/oauth/token?client_id=#{@api_key}&client_secret=#{@api_secret}&grant_type=client_credentials&scope=SMS")
      @token = JSON.parse(response.body)['access_token'] 
    end

    # Receipient number should be in the format of 04xxxxxxxx where x is a digit.
    # Authorization header value should be in the format of "Bearer xxx" where xxx
    # is the access token returned from a token request.
    def send_sms(to: sms_to, body: sms_body)
      [to, body]
      generate_token
      options = { body: {
                    body: body,
                    to: to
                  }.to_json,
                  headers: { "Content-Type" => "application/json", "Authorization" => "Bearer #{@token}" }}
      response = HTTParty.post("https://api.telstra.com/v1/sms/messages", options)
      return response.body
    end

    # Get the status of a previously sent SMS message
    # May return:
    #
    # PEND -> The message is pending and has not yet been sent
    # SENT -> Message has been send, but not delivered
    # DELIVRD -> Message has been delivered
    # READ -> The message has been read by the intended recipeitn
    #
    # Note: Some responses are dependent on the phone network of the user. 
    # Obviously, more info can be grabbed from those on the Telstra network.
    def get_message_status(message_id)
      generate_token
      options = { headers: { "Authorization" => "Bearer #{@token}" } }
      repsonse = HTTParty.post("https://api.telstra.com/v1/sms/messages/#{message_id}")
      return response.body
    end

    def get_message_response(message_id)
      generate_token
      options = { headers: { "Authorization" => "Bearer #{@token}" } }
      repsonse = HTTParty.post("https://api.telstra.com/v1/sms/messages/#{message_id}/response")
      return response.body
    end

  end
end
