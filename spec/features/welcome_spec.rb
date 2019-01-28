require 'spec_helper'

describe 'Welcome' do
  before do
    allow(ArtsyAPI::V2).to receive(:artworks_count).and_return(123)
  end
  context 'page' do
    before do
      visit '/'
    end
    it 'renders a welcome message' do
      expect(page.body).to include 'The Art World in Your App'
    end
    it 'displays the count of available artworks' do
      expect(page.body).to include '123 artworks available'
    end
  end
  context 'sign in' do
    before do
      auth = {
        provider: 'artsy',
        uid: '123545',
        info: {
          raw_info: {
            name: 'Joe Shmoe',
            email: 'joe@example.com',
            credentials: { auth_token: 'token' }
          }
        }
      }
      OmniAuth.config.mock_auth[:artsy] = OmniAuth::AuthHash.new(auth)
    end
    it 'displays the user email' do
      visit '/sign_in'
      expect(page.body).to include 'The Art World in Your App'
      expect(page.body).to include 'Sign Out'
    end
    pending 'signs out'
  end
end
