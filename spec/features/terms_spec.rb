require 'spec_helper'

describe 'Terms' do
  it 'displays terms of use' do
    visit '/terms'
    expect(page.body).to include 'Terms of Use'
  end
end
