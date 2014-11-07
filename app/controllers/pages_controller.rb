class PagesController < ApplicationController
  include MarkdownHelper
  include CacheHelper

  def show
    fail 'Invalid Id' unless params[:id] =~ /^[\w\/]*$/
    filename = Rails.root.join("app/views/content/#{params[:id]}.md")
    @content = Rails.cache.fetch "content/#{params[:id]}/#{File.mtime(filename)}/#{current_user ? current_user.id : nil}" do
      text = File.read(filename)
      text = text.gsub(/\#\{(?<var> [\w\.,_\/:=\+\s\d-]*)\}/x) do
        var = $~[:var]
        if var == 'ArtsyAPI.artsy_api_root'
          ArtsyAPI.artsy_api_root
        elsif var == 'current_user.id'
          current_user ? current_user.id : '...'
        elsif var == 'xapp_token'
          '...' # TODO
        elsif var == 'access_token'
          if current_user
            no_cache!
            current_user.access_token
          else
            '...'
          end
        elsif var == 'application_id'
          application_id
        elsif var.start_with? 'resource://'
          resource var
        elsif var.start_with? 'modelref://'
          modelref var
        else
          "unknown: #{var}"
        end
      end
      render_markdown text
    end
  end

  def start
    if authenticated?
      @client_applications = artsy_client.applications
      @selected_client_application = @client_applications.find { |app| app.id == params[:id] } if params.key?(:id)
      @selected_client_application ||= @client_applications.first if @client_applications.count == 1
    end
  end

  private

  def resource(var)
    parts = var.split('/')[2..-1]
    method = parts[0]
    args = Hash[parts[1..-1].map { |part| part.split('=', 2) }]
    JSON.pretty_generate artsy_client.send(method, args)._get._response.body
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    "error: #{e.message}"
  end

  def modelref(var)
    parts = var.split('/')[2..-1]
    model = parts[0]
    rc = <<-EOS
      Key | Description |
      ---:|:------------|
    EOS
    body = ArtsyAPI.client.connection.get("#{ArtsyAPI.artsy_api_root}/docs/docs").body
    properties = body['models']
    fail 'missing models' unless properties
    properties = properties[model]
    fail "missing #{model}" unless properties
    properties = properties['properties']
    fail 'missing properties' unless properties
    properties.each_pair do |key, desc|
      next unless desc['description']
      rc += "#{key.gsub('_', '\_')} | #{desc['description']}\n"
    end
    rc
  rescue => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    "error: #{e.message}"
  end

  def application_id
    if authenticated?
      artsy_client.applications
        .try(:first)
        .try(:attributes)
        .try(:id) || '...'
    else
      '...'
    end
  end
end
