class PagesController < ApplicationController
  include MarkdownHelper

  def show
    fail 'Invalid Id' unless params[:id] =~ /^[\w\/]*$/
    filename = Rails.root.join("app/views/content/#{params[:id]}.md")
    @content = Rails.cache.fetch "content/#{params[:id]}/#{File.mtime(filename)}/#{current_user ? current_user.id : nil}" do
      text = File.read(filename)
      text = text.gsub(/\#\{(?<var> [\w\.,_]*)\}/x) do
        var = $~[:var]
        case var
        when 'ArtsyAPI.artsy_api_root'
          ArtsyAPI.artsy_api_root
        when 'current_user.id'
          current_user ? current_user.id : '...'
        when 'access_token'
          current_user ? current_user.access_token : '...'
        when 'application_id'
          authenticated? ? artsy_client.links.applications.embedded
            .try(:applications)
            .try(:first)
            .try(:attributes)
            .try(:id) || '...' : '...'
        else
          "unknown: #{var}"
        end
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
