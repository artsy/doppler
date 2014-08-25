require 'spec_helper'

describe 'Welcome' do
  it 'renders a welcome page' do
    visit '/'
    expect(page.body).to include 'Welcome'
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
      expect(page.body).to include 'Welcome'
      expect(page.body).to include 'joe@example.com'
    end
    pending 'signs out'
  end
end
