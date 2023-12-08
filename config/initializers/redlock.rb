# frozen_string_literal: true

RedlockClient = Redlock::Client.new([ENV.fetch('REDIS_URL', 'redis://localhost:6379')])
