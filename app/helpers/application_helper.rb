module ApplicationHelper
  def status_class(response_status)
    case response_status
    when 200
      "response-status-success"   # Green background for success
    when 400..499
      "response-status-warning"   # Yellow background for client errors
    when 500..599
      "response-status-danger"    # Red background for server errors
    end
  end
end
