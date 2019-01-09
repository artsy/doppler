require 'spec_helper'

describe 'Playground' do
  before do
    allow(ArtsyAPI::V2).to receive(:artworks_count).and_return(123)
  end
  it 'requires authentication' do
    visit '/v2/playground'
    expect(current_path).to eq '/'
  end
  context 'logged in' do
    before do
      login_as User.new
    end
    pending 'displays swagger ui'
  end
end
