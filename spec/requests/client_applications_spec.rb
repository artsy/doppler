require 'spec_helper'

describe 'Client Applications' do
  let(:client) { double('Hyperclient') }
  context 'logged in' do
    before do
      allow_any_instance_of(ApplicationController).to receive_messages(
        require_artsy_authentication: nil,
        artsy_client: client
      )
      allow(client).to receive_message_chain(:tokens, :xapp_token, :_post).and_return('foo')
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
        allow(client).to receive_messages(applications: [application], application: application)
      end
      it 'sets nocache headers' do
        get '/client_applications/123'
        expect(response.status).to eq 200
        expect(response.headers['Pragma']).to eq 'no-cache'
      end
    end
  end
end
