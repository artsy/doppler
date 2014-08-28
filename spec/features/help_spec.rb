require 'spec_helper'

describe 'Help' do
  it 'displays help' do
    visit '/help'
    expect(page.body).to include 'Help'
  end
end
