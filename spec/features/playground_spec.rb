require 'spec_helper'

describe 'Playground' do
  it 'requires authentication' do
    visit '/playground'
    expect(current_path).to eq '/'
  end
  context 'logged in' do
    before do
      login_as User.new
    end
    pending 'displays swagger ui'
  end
end
