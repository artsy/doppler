require "spec_helper"

describe "Public API Playground" do
  before do
    allow_any_instance_of(ApplicationController).to receive(:require_artsy_authentication)
    allow(ArtsyAPI::V2).to receive(:artworks_count).and_return(123)
  end
  context "logged in" do
    before do
      get "/v2/playground"
    end
    it "sets nocache headers" do
      expect(response.status).to eq 200
      expect(response.headers["Pragma"]).to eq "no-cache"
    end
  end
end
