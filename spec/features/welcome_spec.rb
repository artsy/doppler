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
  pending 'signs in'
  pending 'signs out'
end
