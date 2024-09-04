Datadog.configure do |c|
  c.tracer enabled: ENV["DATADOG_ENABLED"].present?, hostname: ENV["TRACE_AGENT_HOSTNAME"] || "datadog", distributed_tracing: true, debug: false
  c.use :rails, service_name: "doppler", controller_service: "doppler.controller", cache_service: "doppler.cache", database_service: "doppler.postgres"
  c.use :redis, service_name: "doppler.redis"
  c.use :http, service_name: "doppler.http", distributed_tracing: true
end
