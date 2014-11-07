require 'spec_helper'

describe 'Resources/applications' do
  before do
    allow(ArtsyAPI).to receive_message_chain(:client, :links, :applications, :embedded, :applications).and_return([])
    models_json = {
      'models' => {
        'Application' => {
          'properties' => {
            'client_id' => { 'description' => 'Application client id.' }
          }
        }
      }
    }
    allow(ArtsyAPI).to receive_message_chain(:client, :connection, :get, :body).and_return(models_json)
  end
  context 'signed out' do
    before do
      get '/docs/applications'
    end
    it 'does not set nocache headers' do
      expect(response.status).to eq 200
      expect(response.headers['Pragma']).to be nil
    end
  end
  context 'signed in' do
    before do
      login_as User.new(id: '123', access_token: '456')
      get '/docs/applications'
    end
    it 'sets nocache headers' do
      expect(response.status).to eq 200
      expect(response.headers['Pragma']).to eq 'no-cache'
    end
  end
end
