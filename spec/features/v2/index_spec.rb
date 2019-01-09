require 'spec_helper'

describe 'Docs' do
  context 'root' do
    before do
      visit '/v2'
    end
    it 'displays docs' do
      expect(page.body).to include 'Public API Documentation'
    end
  end
  Rails.application.routes.routes
       .map { |r| r.path.source.match(/\/([\/\w]*)/)[0] }
       .select { |path| path.starts_with?('/v2/docs/') }.each do |path|
    context path do
      before do
        visit path
        sleep 1
      end
      it 'displays a breadcrumb back to docs' do
        expect(page).to have_css "a[href='/v2']"
      end
      it 'does not include any italics' do
        expect(page).to_not have_css 'em'
      end
    end
  end
end
