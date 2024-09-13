class HealthController < ApplicationController
  def ping
    render json: {status: :ok}
  end
end
