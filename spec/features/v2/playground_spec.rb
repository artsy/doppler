require "spec_helper"

describe "Playground" do
  before do
    allow(ArtsyAPI::V2).to receive(:artworks_count).and_return(123)
  end
  it "requires authentication" do
    expect_any_instance_of(ApplicationController).to receive(:require_artsy_authentication)
    visit "/v2/playground"
  end
  context "logged in" do
    pending "displays swagger ui"
  end
end
