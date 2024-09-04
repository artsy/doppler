require "spec_helper"

describe "Resources/applications" do
  before do
    allow(ArtsyAPI::V2).to receive_message_chain(:client, :links, :applications, :embedded, :applications).and_return([])
    models_json = {
      "models" => {
        "Application" => {
          "properties" => {
            "client_id" => {"description" => "Application client id."}
          }
        }
      }
    }
    allow(ArtsyAPI::V2).to receive_message_chain(:client, :connection, :get, :body).and_return(models_json)
  end
  context "signed out" do
    before do
      visit "/v2/docs/applications"
    end
    it "displays a generic curl path" do
      expect(page).to have_css "code", text: 'curl -v "http://localhost:3000/api/applications?user_id=USER_ID" -H "X-Access-Token: ACCESS_TOKEN"'
    end
    it "displays model ref" do
      expect(page).to have_css "td", text: "Application client id."
    end
  end
end
