require "spec_helper"

describe HealthController, type: :controller do
  describe "GET #ping" do
    it "returns a successful response with status ok" do
      get :ping
      expect(response.status).to eq(200)
      expect(response.parsed_body).to eq({"status" => "ok"})
    end
  end
end
