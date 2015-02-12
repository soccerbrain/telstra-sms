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
        end
      end
    end

    describe "get_message_status" do
      before(:each) do
        VCR.use_cassette('get_message_status') do
          @response = telstra_api.send_sms(to: '0425616397', body: 'Hello from Telstra!')
        end
      end

      it 'returns message status' do
        puts @response
        expect(@response).kind_of?(Hash)
      end
    end

    describe "#get_message_response" do
      before(:each) do
        VCR.use_cassette('get_message_response') do
          @response = telstra_api.send_sms(to: '0425616397', body: 'Hello from Telstra!')
        end
      end
      it 'returns message response' do
        puts @response
        expect(@response).kind_of?(Hash)
      end
    end

  end

end
