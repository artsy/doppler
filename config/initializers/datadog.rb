Datadog.configure do |c|
  c.tracing.enabled = ENV["DATADOG_ENABLED"].present?
  c.agent.host = ENV["TRACE_AGENT_HOSTNAME"] || "datadog"
  c.diagnostics.debug = false

  c.tracing.instrument :rails, service_name: "doppler", controller_service: "doppler.controller", cache_service: "doppler.cache", database_service: "doppler.postgres"
  c.tracing.instrument :redis, service_name: "doppler.redis"
  c.tracing.instrument :http, service_name: "doppler.http", distributed_tracing: true
end
