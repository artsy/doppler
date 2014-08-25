require 'spec_helper'

describe 'Welcome' do
  it 'renders a welcome page' do
    visit "/"
    expect(page.body).to include "Welcome"
  end
end
