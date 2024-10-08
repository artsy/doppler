class PagesController < ApplicationController
  include MarkdownHelper
  include CacheHelper

  skip_before_action :require_artsy_authentication

  def show
    raise "Invalid Id" unless params[:id] =~ %r{^[\w/]*$}

    filename = Rails.root.join("app/views/content/#{params[:id]}.md")
    @content = Rails.cache.fetch "content/#{params[:id]}/#{File.mtime(filename)}/#{session[:user_id]}" do
      text = File.read(filename)
      text = text.gsub(%r{\#\{(?<var> [\w.,_/:=+\s\d-]*)\}}x) {
        var = $LAST_MATCH_INFO[:var]
        if var == "ArtsyApi::V2.root"
          ArtsyApi::V2.root
        elsif var == "ArtsyApi::V2.url"
          ArtsyApi::V2.url
        elsif var == "ArtsyApi::V2.docs_url"
          ArtsyApi::V2.docs_url
        elsif var == "ArtsyApi::V1.root"
          ArtsyApi::V1.root
        elsif var == "ArtsyApi::V1.url"
          ArtsyApi::V1.url
        elsif var == "ArtsyApi::V1.docs_url"
          ArtsyApi::V1.docs_url
        elsif var == "application_id"
          application_id
        elsif var.start_with? "resource://"
          resource var
        elsif var.start_with? "modelref://"
          modelref var
        else
          "unknown: #{var}"
        end
      }
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
    args = parts[1..].map { |part| part.split("=", 2) }.to_h
    JSON.pretty_generate artsy_client.send(method, args)._get._response.body
  rescue => e
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
    body = ArtsyApi::V2.client.connection.get("#{ArtsyApi::V2.root}/v2/docs/docs").body
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
        .try(:id) || "..."
    else
      "..."
    end
  end
end
