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
      visit '/docs/applications'
    end
    it 'displays a generic curl path' do
      expect(page).to have_css 'code', text: "curl -v \"http://localhost:3000/api/applications?user_id=...\" -H \"X-Access-Token:...\""
    end
    it 'displays model ref' do
      expect(page).to have_css 'td', text: 'Application client id.'
    end
  end
  context 'signed in' do
    before do
      login_as User.new(id: '123', access_token: '456')
      visit '/docs/applications'
    end
    it 'displays a user specific curl path' do
      expect(page).to have_css 'code', text: "curl -v \"http://localhost:3000/api/applications?user_id=123\" -H \"X-Access-Token:456\""
    end
    it 'no longer display a user-specific path after signout' do
      logout
      visit '/docs/applications'
      expect(page).to have_css 'code', text: "curl -v \"http://localhost:3000/api/applications?user_id=...\" -H \"X-Access-Token:...\""
    end
    it 'displays model ref' do
      expect(page).to have_css 'td', text: 'Application client id.'
    end
  end
end
