require 'spec_helper'

describe 'Resources/status' do
  before do
    # status example
    allow(ArtsyAPI).to receive(:xapp_token).and_return('token')
    allow(ArtsyAPI).to receive_message_chain(:client, :connection, :get, :body).and_return({
                                                                                             'models' => {
                                                                                               'System' => {
                                                                                                 'properties' => {
                                                                                                   'status' => { 'description' => 'System status description.' }
                                                                                                 }
                                                                                               }
                                                                                             }
                                                                                           })
    allow(ArtsyAPI).to receive_message_chain(:client, :links, :status, :expand, :get, :body).and_return(foo: 'bar')
  end
  context 'signed out' do
    before do
      visit '/docs/status'
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
