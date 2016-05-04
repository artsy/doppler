require 'spec_helper'

describe 'Start' do
  it 'says to login' do
    visit '/start'
    expect(page.body).to include 'Getting Started'
    expect(page.body).to include 'Sign In'
  end
  context 'logged in' do
    before do
      login_as User.new
      # xapp token request from start/show.html.haml
      allow(Net::HTTP).to receive_message_chain(:post_form, :body).and_return({ xapp_token: 'token' }.to_json)
      # example of retrieving an artist by id
      allow(ArtsyAPI).to receive_message_chain(:client, :artist, :_response, :body).and_return({ 'id' => 'andy-warhol' })
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
        allow(ArtsyAPI).to receive_message_chain(:client, :_links, :applications).and_return([])
      end
      it 'creates an app' do
        visit '/start'
        expect(page.body).to include 'Create an App'
        expect(ArtsyAPI).to receive_message_chain(:client, :applications, :_post).with(name: 'Name', redirect_urls: []).and_return(application)
        click_link 'here'
        fill_in 'Name', with: 'Name'
        allow(ArtsyAPI).to receive_message_chain(:client, :applications).and_return([application])
        click_button 'Save'
        expect(page.body).to include 'Use Your App'
        expect(page.body).to include 'client_id'
      end
    end
    context 'with apps' do
      context 'with an application' do
        before do
          allow(ArtsyAPI).to receive_message_chain(:client, :applications).and_return([application])
          visit '/start'
        end
        it 'selects the app' do
          expect(page.body).to include 'Use Your App'
          expect(page.body).to include 'client_id'
        end
        it 'syntax highlights code' do
          expect(page.all('.CodeRay .code pre').count).to be > 0
        end
        it 'adds style to tables' do
          expect(page.all('table.table-bordered.table-striped').count).to be > 0
        end
      end
      context 'with two apps' do
        let(:application1) do
          Hashie::Mash.new(
            id: '1',
            name: 'One',
            client_id: 'client_id1',
            client_secret: 'client_secret1',
            created_at: Time.now.utc.to_s,
            updated_at: Time.now.utc.to_s
          )
        end
        let(:application2) do
          Hashie::Mash.new(
            id: '2',
            name: 'Two',
            client_id: 'client_id2',
            client_secret: 'client_secret2',
            created_at: Time.now.utc.to_s,
            updated_at: Time.now.utc.to_s
          )
        end
        before do
          allow(ArtsyAPI).to receive_message_chain(:client, :applications).and_return([application1, application2])
        end
        it 'lets pick the app' do
          visit '/start'
          expect(page.body).to include 'Select One of Your Apps'
        end
        it 'picks the app' do
          visit '/start?id=2'
          expect(page.body).to include 'Use Your App'
          expect(page.body).to include 'client_id2'
        end
      end
    end
  end
end
