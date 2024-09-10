Datadog.configure do |c|
  c.tracing.enabled = ENV["DATADOG_ENABLED"].present?
  c.agent.host = ENV["TRACE_AGENT_HOSTNAME"] || "datadog"
  c.diagnostics.debug = false

  c.tracing.instrument :rails do |rails|
    rails.service_name = "doppler"
    rails.controller_service = "doppler.controller"
    rails.cache_service = "doppler.cache"
    rails.database_service = "doppler.postgres"
  end

  c.tracing.instrument :redis, service_name: "doppler.redis"

  c.tracing.instrument :http do |http|
    http.service_name = "doppler.http"
    http.distributed_tracing = true
  end
end
