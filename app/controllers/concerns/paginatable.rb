module Paginatable
  extend ActiveSupport::Concern

  included do
    before_action :set_pagination
  end

  def set_pagination
    @page = params[:page] || 1
    @size = params[:size] || 10
  end

  def calculate_total_pages(total_records, size)
    (total_records / size.to_f).ceil
  end
end
