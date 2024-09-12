require "spec_helper"
describe "Resources/applications" do
  before do
    allow(ArtsyApi::V2).to receive_message_chain(:client, :links, :applications, :embedded, :applications).and_return([])
    models_json = {
      "models" => {
        "Application" => {
          "properties" => {
            "client_id" => {"description" => "Application client id."}
          }
        }
      }
    }
    allow(ArtsyApi::V2).to receive_message_chain(:client, :connection, :get, :body).and_return(models_json)
  end
  context "signed in" do
    before do
      allow_any_instance_of(ApplicationController).to receive(:authenticated?).and_return(true)
      get "/v2/docs/applications"
    end
    it "sets nocache headers" do
      expect(response.status).to eq 200
      expect(response.headers["Cache-Control"]).to include("private")
    end
  end
end
