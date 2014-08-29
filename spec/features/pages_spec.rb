require 'spec_helper'

describe 'Authentication' do
  context 'authentication' do
    before do
      visit '/docs/authentication'
    end
    it 'displays authentication' do
      expect(page.body).to include 'Authenticate with an XAPP Token'
    end
    it 'syntax highlights code' do
      expect(page.all('.CodeRay .code pre').count).to be > 0
    end
    it 'adds style to tables' do
      expect(page.all('table.table-bordered.table-striped').count).to be > 0
    end
  end
  context 'docs' do
    before do
      visit '/docs'
    end
    it 'displays docs' do
      expect(page.body).to include 'Documentation'
    end
  end
end
