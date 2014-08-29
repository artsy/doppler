class PagesController < ApplicationController
  include MarkdownHelper

  def show
    fail 'Invalid Id' unless params[:id] =~ /^\w*$/
    filename = Rails.root.join("public/content/#{params[:id]}.md")
    @content = Rails.cache.fetch "content/#{params[:id]}/#{File.mtime(filename)}" do
      text = File.read(filename)
      text.gsub!(/\#\{(.*)\}/) do
        eval Regexp.last_match[1]
      end
      render_markdown text
    end
  end

  def start
    if authenticated?
      @client_applications = artsy_client.links.applications.embedded.applications
      @selected_client_application = @client_applications.find { |app| app.attributes.id == params[:id] } if params.key?(:id)
      @selected_client_application ||= @client_applications.first if @client_applications.count == 1
    end
  end
end
