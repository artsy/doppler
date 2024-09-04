class PagesController < ApplicationController
  include MarkdownHelper
  include CacheHelper

  skip_before_action :require_artsy_authentication

  def show
    raise "Invalid Id" unless params[:id] =~ %r{^[\w/]*$}

    filename = Rails.root.join("app/views/content/#{params[:id]}.md")
    @content = Rails.cache.fetch "content/#{params[:id]}/#{File.mtime(filename)}/#{session[:user_id]}" do
      text = File.read(filename)
      text = text.gsub(%r{\#\{(?<var> [\w\.,_/:=\+\s\d-]*)\}}x) do
        var = $LAST_MATCH_INFO[:var]
        if var == "ArtsyAPI::V2.root"
          ArtsyAPI::V2.root
        elsif var == "ArtsyAPI::V2.url"
          ArtsyAPI::V2.url
        elsif var == "ArtsyAPI::V2.docs_url"
          ArtsyAPI::V2.docs_url
        elsif var == "ArtsyAPI::V1.root"
          ArtsyAPI::V1.root
        elsif var == "ArtsyAPI::V1.url"
          ArtsyAPI::V1.url
        elsif var == "ArtsyAPI::V1.docs_url"
          ArtsyAPI::V1.docs_url
        elsif var == "application_id"
          application_id
        elsif var.start_with? "resource://"
          resource var
        elsif var.start_with? "modelref://"
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
    parts = var.split("/")[2..]
    method = parts[0]
    args = Hash[parts[1..].map { |part| part.split("=", 2) }]
    JSON.pretty_generate artsy_client.send(method, args)._get._response.body
  rescue StandardError => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    "error: #{e.message}"
  end

  def modelref(var)
    parts = var.split("/")[2..]
    model = parts[0]
    rc = <<-TEXT
      Key | Description |
      ---:|:------------|
    TEXT
    body = ArtsyAPI::V2.client.connection.get("#{ArtsyAPI::V2.root}/v2/docs/docs").body
    properties = body["models"]
    raise "missing models" unless properties

    properties = properties[model]
    raise "missing #{model}" unless properties

    properties = properties["properties"]
    raise "missing properties" unless properties

    properties.each_pair do |key, desc|
      next unless desc["description"]

      rc += "#{key.gsub("_", '\_')} | #{desc["description"]}\n"
    end
    rc
  rescue StandardError => e
    Rails.logger.error e
    Rails.logger.error e.backtrace.join("\n")
    "error: #{e.message}"
  end

  def application_id
    if authenticated?
      artsy_client.applications
                  .try(:first)
                  .try(:attributes)
                  .try(:id) || "..."
    else
      "..."
    end
  end
end
