require 'spec_helper'

RSpec.describe SessionController, type: :controller do
  describe 'GET #new' do
    context 'unauthenticated' do
      before do
        allow(subject).to receive(:authenticated?).and_return false
      end
      it 'stores redirect_uri' do
        get :new, params: { redirect_uri: '/applications' }
        expect(session[:redirect_uri]).to eq '/applications'
      end
    end
    context 'authenticated' do
      let(:user) { double(User, id: 1, name: 'Name', email: 'email@example.com') }
      before do
        allow(subject).to receive(:authenticated?).and_return true
        allow(subject).to receive(:current_user).and_return user
      end
      it 'redirects to root' do
        get :new, params: { redirect_uri: '/applications' }
        expect(response).to redirect_to('/')
      end
      it 'sets sentry context' do
        expect(Raven).to receive(:user_context).with(
          id: user.id,
          username: user.name,
          email: user.email
        )
        get :new, params: { redirect_uri: '/applications' }
      end
    end
  end
  describe 'GET #destroy' do
    it 'redirect to gravity API logout page' do
      allow(subject).to receive(:set_raven_context)
      get :destroy
      expect(response).to redirect_to('http://localhost:3000/users/sign_out?redirect_uri=http%3A%2F%2Ftest.host%2F')
    end
  end
  describe 'POST #create' do
    let(:warden) { double(Warden::Manager) }
    before do
      expect(subject).to receive(:set_raven_context)
      expect(subject).to receive(:warden).and_return(warden)
      expect(warden).to receive(:set_user)
    end
    it 'redirects' do
      session[:redirect_uri] = '/applications'
      post :create, params: { provider: 'artsy' }
      expect(response).to redirect_to('http://test.host/applications')
    end
    it 'does not make an open redirect' do
      session[:redirect_uri] = 'http://bad.stuff/applications'
      post :create, params: { provider: 'artsy' }
      expect(response).to redirect_to('http://test.host/applications')
    end
    it 'defaults to / with no redirect' do
      session[:redirect_uri] = nil
      post :create, params: { provider: 'artsy' }
      expect(response).to redirect_to('http://test.host/')
    end
  end
end
