require 'spec_helper'

describe 'Resources/status' do
  before do
    # xapp token for the resource examples
    allow(Net::HTTP).to receive_message_chain(:post_form, :code).and_return('201')
    allow(Net::HTTP).to receive_message_chain(:post_form, :body).and_return({
      xapp_token: 'token'
    }.to_json)
    # system model reference
    allow(Net::HTTP).to receive_message_chain(:get_response, :body).and_return({
      models: {
        'System' => {
          properties: {
            status: { description: 'System status description.' }
          }
        }
      }
    }.to_json)
    # status example
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
