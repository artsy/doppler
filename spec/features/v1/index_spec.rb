require "spec_helper"

describe "Partner API" do
  context "root" do
    before do
      visit "/v1"
    end
    it "displays docs" do
      expect(page.body).to include "Partner API Documentation"
    end
  end
  Rails.application.routes.routes
       .map { |r| r.path.source.match(%r{/([/\w]*)})[0] }
       .select { |path| path.starts_with?("/v1/docs/") }.each do |path|
    context path do
      before do
        visit path
        sleep 1
      end
      it "displays a breadcrumb back to docs" do
        expect(page).to have_css "a[href='/v1']"
      end
      it "does not include any italics" do
        expect(page).to_not have_css "em"
      end
    end
  end
end
