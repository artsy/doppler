require 'spec_helper'

describe 'Playground' do
  before do
    allow(ArtsyAPI).to receive(:artworks_count).and_return(123)
  end
  context 'logged in' do
    before do
      login_as User.new
      get '/playground'
    end
    it 'sets nocache headers' do
      expect(response.status).to eq 200
      expect(response.headers['Pragma']).to eq 'no-cache'
    end
  end
end
