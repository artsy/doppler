module OpenRedirectHelper
  def safe_redirect_uri(redirect_uri)
    return nil if redirect_uri.blank?
    begin
      root_url = URI.parse("#{request.protocol}#{request.host_with_port}")
      parsed_url = root_url + redirect_uri
      return nil if parsed_url.is_a?(URI::Data)
      return nil unless parsed_url.is_a?(URI::HTTP)
      return parsed_url.to_s if parsed_url.host.nil?
      return parsed_url.to_s if parsed_url.scheme == request.scheme && parsed_url.host == request.host && parsed_url.port == request.port
      nil
    rescue URI::InvalidURIError
      nil
    end
  end
end
