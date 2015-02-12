require 'spec_helper'

describe Telstra::SMS do

  describe "Sending SMS" do
    let(:telstra_api){ Telstra::SMS.new(ENV['TELSTRA_API'], ENV['TELSTRA_SECRET']) }
    
    describe "#generate_token" do
      it 'returns token' do
        VCR.use_cassette('generate_token') do
          response = telstra_api.generate_token
          expect(response).kind_of?(String)
        end
      end
    end

    describe "#send_sms" do
      it 'returns a success' do
        VCR.use_cassette('send_sms') do
          response = telstra_api.send_sms(to: '0425616397', body: 'Hello from Telstra!')
          expect(response).kind_of?(Hash)
          expect(response.has_key?('messageId')).to eq true
        end
      end
    end

    describe "get_message_status" do
      it 'returns message status' do
        VCR.use_cassette('get_message_status') do
          sms_response = telstra_api.send_sms(to: '0425616397', body: 'Hello from Telstra!')
          message_id = sms_response['messageId']
          response = telstra_api.get_message_status(message_id)

          expect(response).kind_of?(Hash)
          expect(response.has_key?('to')).to eq true
          expect(response.has_key?('receivedTimestamp')).to eq true
          expect(response.has_key?('sentTimestamp')).to eq true
          expect(response.has_key?('status')).to eq true
        end
      end
    end

    describe "#get_message_response" do
      ## Can a response be simulated?
      it 'returns message response' do
        VCR.use_cassette('get_message_response') do
          sms_response = telstra_api.send_sms(to: '0425616397', body: 'Hello from Telstra!')
          message_id = sms_response['messageId']
          response = telstra_api.get_message_response(message_id)

          expect(response).kind_of?(Array)

          expect(response[0].has_key?('from')).to eq true
          expect(response[0].has_key?('acknowledgedTimestamp')).to eq true
          expect(response[0].has_key?('content')).to eq true
        end
      end
    end

  end

end
