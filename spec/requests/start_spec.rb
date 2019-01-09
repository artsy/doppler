require 'spec_helper'

describe 'Start' do
  context 'logged in' do
    before do
      login_as User.new
      # xapp token request from start/show.html.haml
      allow(Net::HTTP).to receive_message_chain(:post_form, :body).and_return({ xapp_token: 'token' }.to_json)
      # example of retrieving an artist by id
      allow(ArtsyAPI::V2).to receive_message_chain(:client, :artist, :_response, :body).and_return({ 'id' => 'andy-warhol' })
    end
    let(:application) do
      Hashie::Mash.new(
        id: '1',
        name: 'One',
        client_id: 'client_id',
        client_secret: 'client_secret',
        created_at: Time.now.utc.to_s,
        updated_at: Time.now.utc.to_s
      )
    end
    context 'without apps' do
      before do
        allow(ArtsyAPI::V2).to receive_message_chain(:client, :_links, :applications).and_return([])
        get '/v2/start'
      end
      it 'does not set nocache headers' do
        expect(response.status).to eq 200
        expect(response.headers['Pragma']).to be nil
      end
    end
    context 'with apps' do
      context 'with an application' do
        before do
          allow(ArtsyAPI::V2).to receive_message_chain(:client, :applications).and_return([application])
          get '/v2/start'
        end
        it 'sets nocache headers' do
          expect(response.status).to eq 200
          expect(response.headers['Pragma']).to eq 'no-cache'
        end
      end
    end
  end
end
