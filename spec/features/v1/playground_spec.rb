require 'spec_helper'

describe 'Playground' do
  it 'requires authentication' do
    expect_any_instance_of(ApplicationController).to receive(:require_artsy_authentication)
    visit '/v1/playground'
  end
end
