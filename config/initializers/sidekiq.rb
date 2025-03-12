# frozen_string_literal: true

redis = { url: %w[development test].include?(Rails.env) ? ENV.fetch('GO_FOX_SIDEKIQ_REDIS_URL', 'redis://localhost:6379/0') : ENV.fetch('SIDEKIQ_REDIS_URL', 'redis://127.0.0.1:6379/5') }

Sidekiq.configure_client do |config|
  config.redis = redis
end
Sidekiq.configure_server do |config|
  config.redis = redis
end
