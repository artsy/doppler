require 'spec_helper'

describe 'Docs/authentication' do
  before do
    visit '/v2/docs/authentication'
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
  it 'marks up alert blocks' do
    expect(page.all('div.alert.alert-warning').count).to be > 0
    expect(page).to have_css 'div.alert.alert-warning', text: 'This will be implemented in the future.'
  end
  it 'includes correct oauth2 links' do
    expect(page.body).to include 'curl -v "http://localhost:3000/oauth2/authorize'
  end
end
