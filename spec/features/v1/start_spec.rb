require "spec_helper"

describe "V1 Start" do
  it "says to login" do
    visit "/v1/start"
    expect(page.body).to include "Getting Started"
    expect(page.body).to include "Sign In"
  end
  context "logged in" do
    before do
      # xapp token request from start/show.html.haml
      allow_any_instance_of(ApplicationController).to receive_messages(
        authenticated?: true,
        require_artsy_authentication: nil
      )
      allow(Net::HTTP).to receive_message_chain(:post_form, :body).and_return({xapp_token: "token"}.to_json)
    end
    let(:application) do
      Hashie::Mash.new(
        id: "1",
        name: "One",
        client_id: "client_id",
        client_secret: "client_secret",
        api_version: 1,
        created_at: Time.now.utc.to_s,
        updated_at: Time.now.utc.to_s
      )
    end
    context "without apps" do
      before do
        allow(ArtsyAPI::V2).to receive_message_chain(:client, :_links, :applications).and_return([])
      end
      it "creates an app" do
        visit "/v1/start"
        expect(page.body).to include "Create an App"
        expect(ArtsyAPI::V2).to receive_message_chain(:client, :applications, :_post).with(name: "Name", redirect_urls: []).and_return(application)
        click_link "here"
        fill_in "Name", with: "Name"
        allow(ArtsyAPI::V2).to receive_message_chain(:client, :applications).and_return([application])
        click_button "Save"
        sleep 1
        expect(page.body).to include "Use Your App"
        expect(page.body).to include "client_id"
      end
    end
    context "with apps" do
      context "with an application" do
        before do
          allow(ArtsyAPI::V2).to receive_message_chain(:client, :applications).and_return([application])
          visit "/v1/start"
        end
        it "selects the app" do
          expect(page.body).to include "Use Your App"
          expect(page.body).to include "client_id"
        end
        it "adds style to tables" do
          expect(page.all("table.table-bordered.table-striped").count).to be > 0
        end
      end
      context "with two apps" do
        let(:application1) do
          Hashie::Mash.new(
            id: "1",
            name: "One",
            api_version: 1,
            client_id: "client_id1",
            client_secret: "client_secret1",
            created_at: Time.now.utc.to_s,
            updated_at: Time.now.utc.to_s
          )
        end
        let(:application2) do
          Hashie::Mash.new(
            id: "2",
            name: "Two",
            api_version: 1,
            client_id: "client_id2",
            client_secret: "client_secret2",
            created_at: Time.now.utc.to_s,
            updated_at: Time.now.utc.to_s
          )
        end
        before do
          allow(ArtsyAPI::V2).to receive_message_chain(:client, :applications).and_return([application1, application2])
        end
        it "lets pick the app" do
          visit "/v1/start"
          expect(page.body).to include "Select One of Your Apps"
        end
        it "picks the app" do
          visit "/v1/start?id=2"
          expect(page.body).to include "Use Your App"
          expect(page.body).to include "client_id2"
        end
      end
      context "with no v1 apps" do
        let(:application1) do
          Hashie::Mash.new(
            id: "1",
            name: "One",
            api_version: 2,
            client_id: "client_id1",
            client_secret: "client_secret1",
            created_at: Time.now.utc.to_s,
            updated_at: Time.now.utc.to_s
          )
        end
        before do
          allow(ArtsyAPI::V2).to receive_message_chain(:client, :applications).and_return([application1])
        end
        it "tells user to obtain access" do
          visit "/v1/start"
          expect(page.body).to include "Request Partner Access"
        end
      end
    end
  end
end
