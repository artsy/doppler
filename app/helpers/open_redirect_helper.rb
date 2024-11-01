module OpenRedirectHelper
  def safe_redirect_uri(redirect_uri)
    return nil if redirect_uri.blank?

    begin
      # Build the root URI using request details
      root_url = URI.parse("#{request.protocol}#{request.host_with_port}")
      parsed_url = URI.join(root_url.to_s, redirect_uri.to_s)

      # Check if parsed URL is a data URI or another unsafe scheme
      return nil if parsed_url.scheme == "data"

      # Ensure URL uses HTTP or HTTPS and matches the host and scheme of the request
      return nil unless parsed_url.is_a?(URI::HTTP) || parsed_url.is_a?(URI::HTTPS)
      return parsed_url.to_s if parsed_url.host.nil? && parsed_url.relative?
      return parsed_url.to_s if parsed_url.scheme == request.scheme && parsed_url.host == request.host && parsed_url.port == request.port

      # Return nil for all other cases
      nil
    rescue URI::InvalidURIError
      nil
    end
  end
end
