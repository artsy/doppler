require 'spec_helper'

describe 'Partner API Terms' do
  it 'displays terms of use' do
    visit '/v1/terms'
    expect(page.body).to include 'PARTNER API TERMS OF USE'
  end
end
