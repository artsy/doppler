class HelpController < ApplicationController
  skip_before_action :require_artsy_authentication

  def show; end
end
