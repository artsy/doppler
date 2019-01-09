require 'spec_helper'

describe 'Resources/status' do
  before do
    # status example
    allow(ArtsyAPI::V2).to receive(:xapp_token).and_return('token')
    models_json = {
      'models' => {
        'System' => {
          'properties' => {
            'status' => { 'description' => 'System status description.' }
          }
        }
      }
    }
    allow(ArtsyAPI::V2).to receive_message_chain(:client, :connection, :get, :body).and_return(models_json)
    allow(ArtsyAPI::V2).to receive_message_chain(:client, :status, :_get, :_response, :body).and_return(foo: 'bar')
  end
  context 'signed out' do
    before do
      visit '/v2/docs/status'
    end
    it 'renders model refs' do
      expect(page).to have_css 'td', text: 'status'
      expect(page).to have_css 'td', text: 'System status description.'
    end
    it 'renders resources' do
      expect(page).to have_content '"foo": "bar"'
    end
  end
end
