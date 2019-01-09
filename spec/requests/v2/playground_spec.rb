require 'spec_helper'

describe 'Public API Playground' do
  before do
    allow(ArtsyAPI::V2).to receive(:artworks_count).and_return(123)
  end
  context 'logged in' do
    before do
      login_as User.new
      get '/v2/playground'
    end
    it 'sets nocache headers' do
      expect(response.status).to eq 200
      expect(response.headers['Pragma']).to eq 'no-cache'
    end
  end
end
