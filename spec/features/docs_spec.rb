require 'spec_helper'

describe 'Docs' do
  context 'root' do
    before do
      visit '/docs'
    end
    it 'displays docs' do
      expect(page.body).to include 'Documentation'
    end
  end
end
