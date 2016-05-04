require 'spec_helper'

describe 'Client Applications' do
  before do
    allow(ArtsyAPI).to receive(:artworks_count).and_return(123)
  end
  it 'requires authentication' do
    visit '/client_applications'
    expect(current_path).to eq '/'
  end
  context 'logged in' do
    before do
      login_as User.new
    end
    context 'without applications' do
      before do
        allow(ArtsyAPI).to receive_message_chain(:client, :applications).and_return([])
      end
      it 'creates an app' do
        expect(ArtsyAPI).to receive_message_chain(:client, :applications, :_post).with(name: 'Name', redirect_urls: [])
        visit '/client_applications'
        click_link 'Create a New App'
        fill_in 'Name', with: 'Name'
        click_button 'Save'
      end
      context 'open-redirect' do
        before do
          allow(ArtsyAPI).to receive_message_chain(:client, :applications, :_post)
        end
        ['http://google.com', 'http:/google.com'].each do |url|
          it "is not vulnerable to an open redirect to #{url}" do
            visit "/client_applications/new?redirect_uri=#{url}"
            fill_in 'Name', with: 'Name'
            click_button 'Save'
            expect(current_url).to end_with '/client_applications'
          end
        end
        it 'redirects to a relative uri' do
          visit '/client_applications/new?redirect_uri=/docs'
          fill_in 'Name', with: 'Name'
          click_button 'Save'
          expect(current_url).to end_with '/docs'
        end
        it 'redirects to a full uri' do
          visit '/docs'
          redirect_uri = current_url
          visit "/client_applications/new?redirect_uri=#{redirect_uri}"
          fill_in 'Name', with: 'Name'
          click_button 'Save'
          expect(current_url).to eq redirect_uri
        end
      end
    end
    context 'with an application' do
      let(:application) do
        Hashie::Mash.new(
          id: '1',
          name: 'One',
          client_id: 'client_id',
          client_secret: 'client_secret',
          redirect_urls: [],
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
      it 'displays the app in a table' do
        visit '/client_applications'
        expect(page).to have_css 'td.name', text: 'One'
        expect(page).to have_css 'td.client_id', text: 'client_id'
      end
      it 'displays the app' do
        visit '/client_applications/123'
        expect(page).to have_css 'td#name', text: 'One'
        expect(page).to have_css 'td#client_id', text: 'client_id'
        expect(page).to have_css 'td#client_secret', text: 'client_secret'
      end
      it 'edits the app' do
        expect(application).to receive(:_put).with(name: 'Updated', redirect_urls: ['http://example.org'])
        visit '/client_applications'
        click_link 'edit'
        fill_in 'Name', with: 'Updated'
        fill_in 'Redirect urls', with: 'http://example.org'
        click_button 'Save'
      end
      it 'destroys the app' do
        expect(application).to receive(:_delete)
        visit '/client_applications'
        click_link 'destroy'
        click_link 'OK'
      end
    end
    context 'with an application with enabled=false' do
      let(:application) do
        Hashie::Mash.new(
          id: '1',
          name: 'One',
          client_id: 'client_id',
          client_secret: 'client_secret',
          redirect_urls: [],
          created_at: Time.now.utc.to_s,
          updated_at: Time.now.utc.to_s,
          enabled: false,
          _attributes: {
            id: '1'
          }
        )
      end
      before do
        allow(ArtsyAPI).to receive_message_chain(:client, :applications).and_return([application])
        allow(ArtsyAPI).to receive_message_chain(:client, :application).and_return(application)
      end
      it 'displays the app access in a table' do
        visit '/client_applications'
        expect(page).to have_css 'td.enabled', text: 'No'
      end
      it 'displays the app' do
        visit '/client_applications/123'
        expect(page).to have_css 'td#enabled', text: 'No'
      end
      it 'edits the app' do
        visit '/client_applications'
        click_link 'edit'
        expect(page).to have_css('td#enabled'), text: 'No'
      end
    end
    context 'with an application with published_artworks_access_enabled' do
      let(:application) do
        Hashie::Mash.new(
          id: '1',
          name: 'One',
          client_id: 'client_id',
          client_secret: 'client_secret',
          redirect_urls: [],
          created_at: Time.now.utc.to_s,
          updated_at: Time.now.utc.to_s,
          enabled: true,
          published_artworks_access_enabled: true,
          _attributes: {
            id: '1'
          }
        )
      end
      before do
        allow(ArtsyAPI).to receive_message_chain(:client, :applications).and_return([application])
        allow(ArtsyAPI).to receive_message_chain(:client, :application).and_return(application)
      end
      it 'displays the app access in a table' do
        visit '/client_applications'
        expect(page).to have_css 'td.enabled', text: 'Yes + Published Artworks'
      end
      it 'displays the app' do
        visit '/client_applications/123'
        expect(page).to have_css '.alert.alert-success', text: 'This application has access to all published artworks.'
        expect(page).to have_css 'td#enabled', text: 'Yes'
      end
      it 'edits the app' do
        visit '/client_applications'
        click_link 'edit'
        expect(page).to have_css '.alert.alert-success', text: 'This application has access to all published artworks.'
        expect(page).to have_css 'td#enabled', text: 'Yes'
      end
    end
  end
end
