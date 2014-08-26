require 'spec_helper'

describe 'Welcome' do
  it 'renders a welcome page' do
    visit '/'
    expect(page.body).to include 'More Art in Your App'
    expect(page.body).to include 'Sign In'
  end
  context 'sign in' do
    before do
      auth =  {
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
      expect(page.body).to include 'More Art in Your App'
      expect(page.body).to include 'Sign Out'
    end
    pending 'signs out'
  end
end
