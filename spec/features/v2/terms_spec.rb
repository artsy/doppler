require 'spec_helper'

describe 'Public API Terms' do
  it 'displays terms of use' do
    visit '/v2/terms'
    expect(page.body).to include 'PUBLIC API TERMS OF USE'
  end
end
