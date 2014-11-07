require 'spec_helper'

describe 'Client Applications' do
  before do
    allow(ArtsyAPI).to receive(:artworks_count).and_return(123)
  end
  context 'logged in' do
    before do
      login_as User.new
    end
    context 'with an application' do
      let(:application) do
        Hashie::Mash.new(
          id: '1',
          name: 'One',
          client_id: 'client_id',
          client_secret: 'client_secret',
          created_at: Time.now.utc.to_s,
          updated_at: Time.now.utc.to_s,
          _attributes: {
            id: '1'
          }
        )
      end
      before do
        allow(ArtsyAPI).to receive_message_chain(:client, :applications).and_return([application])
        allow(ArtsyAPI).to receive_message_chain(:client, :application).and_return(application)
      end
      it 'sets nocache headers' do
        get '/client_applications/123'
        expect(response.status).to eq 200
        expect(response.headers['Pragma']).to eq 'no-cache'
      end
    end
  end
end
