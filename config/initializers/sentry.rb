Raven.configure do |config|
  config.processors -= [Raven::Processor::PostData]
end
