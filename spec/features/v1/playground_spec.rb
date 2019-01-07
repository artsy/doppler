require 'spec_helper'

describe 'Playground' do
  it 'requires authentication' do
    visit '/v1/playground'
    expect(current_path).to eq '/'
  end
end
