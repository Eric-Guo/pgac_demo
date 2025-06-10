Sidekiq.configure_server do |config|
  config.average_scheduled_poll_interval = 1
  config.redis = {url: "redis://127.0.0.1:6379/3"}
end

Sidekiq.configure_client do |config|
  config.redis = {url: "redis://127.0.0.1:6379/3"}
end
