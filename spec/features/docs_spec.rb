require 'spec_helper'

describe 'Docs' do
  context 'root' do
    before do
      visit '/docs'
    end
    it 'displays docs' do
      expect(page.body).to include 'Documentation'
    end
  end
  Rails.application.routes.routes
    .map { |r| r.path.source.match(/\/([\/\w]*)/)[0] }
    .select { |path| path.starts_with?('/docs/') }.each do |path|
    context path do
      before do
        visit path
      end
      it 'displays a breadcrumb back to docs' do
        expect(page).to have_css "a[href='/docs']"
      end
    end
  end
end
