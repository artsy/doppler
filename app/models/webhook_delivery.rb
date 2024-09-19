class WebhookDelivery
  include ActiveModel::Model

  attr_accessor :id, :response_status, :error_class, :created_at, :completed_at, :webhook_event

  def initialize(attributes = {})
    super
    if attributes[:webhook_event].present?
      self.webhook_event = WebhookEvent.new(attributes[:webhook_event])
    end
  end
end

# EX response from API
# [{:created_at=>1726763797,
#   :error_class=>nil,
#   :id=>"654b4288-8edc-4d90-863d-500d16c62e0d",
#   :response_status=>nil,
#   :webhook_event=>
#    {:created_at=>1726763549,
#     :data=>
#      {:artwork_id=>"artwork_id",
#       :external_id=>"artwork.external_id",
#       :price_cents=>12500,
#       :availability=>"sold",
#       :price_listed=>"125",
#       :import_source=>"jackie",
#       :price_display=>"exact",
#       :sales_tax_cents=>200,
#       :shipping_total_cents=>100},
#     :id=>"05eba7d1-7309-4256-b24c-c078bedea048",
#     :name=>"artwork.order.approved",
#     :partner_id=>"5f80bfefe8d808000ea212c1"},
#   :webhook_id=>"bfce7286-5e1f-4425-b2bd-26f613c469a1"},
#  {:created_at=>1726763786,
#   :error_class=>nil,
#   :id=>"5b2fdf36-b79b-4cad-a69c-eed81a3ada18",
#   :response_status=>nil,
#   :webhook_event=>
#    {:created_at=>1726763549,
#     :data=>
#      {:artwork_id=>"artwork_id",
#       :external_id=>"artwork.external_id",
#       :price_cents=>12500,
#       :availability=>"sold",
#       :price_listed=>"125",
#       :import_source=>"jackie",
#       :price_display=>"exact",
#       :sales_tax_cents=>200,
#       :shipping_total_cents=>100},
#     :id=>"05eba7d1-7309-4256-b24c-c078bedea048",
#     :name=>"artwork.order.approved",
#     :partner_id=>"5f80bfefe8d808000ea212c1"},
#   :webhook_id=>"bfce7286-5e1f-4425-b2bd-26f613c469a1"}]
