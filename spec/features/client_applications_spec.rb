require 'spec_helper'

describe 'Client Applications' do
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
        allow(ArtsyAPI).to receive_message_chain(:client, :links, :applications, :embedded, :applications).and_return([])
      end
      it 'renders a list of apps' do
        visit '/client_applications'
        expect(page.body).to include 'My Apps'
      end
      it 'creates an app' do
        expect(ArtsyAPI).to receive_message_chain(:client, :links, :applications, :post).with(name: 'Name')
        visit '/client_applications'
        click_link 'Create a New App'
        fill_in 'Name', with: 'Name'
        click_button 'Save'
      end
    end
    context 'with an application' do
      let(:application) do
        Hashie::Mash.new(
          attributes: {
            id: '1',
            name: 'One',
            client_id: 'client_id',
            client_secret: 'client_secret',
            created_at: Time.now.utc.to_s,
            updated_at: Time.now.utc.to_s
          })
      end
      before do
        allow(ArtsyAPI).to receive_message_chain(:client, :links, :applications, :embedded, :applications).and_return([application])
        allow(ArtsyAPI).to receive_message_chain(:client, :links, :application, :expand, :resource).and_return(application)
      end
      it 'displays the app in a table' do
        visit '/client_applications'
        expect(page.body).to include 'One'
        expect(page.body).to include 'client_id'
      end
      it 'displays the app' do
        visit '/client_applications/123'
        expect(page.body).to include 'One'
        expect(page.body).to include 'client_id'
        expect(page.body).to include 'client_secret'
      end
      it 'edits the app' do
        expect(application).to receive(:put).with(name: 'Updated')
        visit '/client_applications'
        click_link 'edit'
        fill_in 'Name', with: 'Updated'
        click_button 'Save'
      end
      it 'destroys the app' do
        expect(application).to receive(:delete)
        visit '/client_applications'
        click_link 'destroy'
        click_link 'OK'
      end
    end
  end
end
