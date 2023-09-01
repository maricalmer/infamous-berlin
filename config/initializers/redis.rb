Redis.current = Redis.new(url: ENV["REDISCLOUD_URL"], port: ENV['REDIS_PORT'], ssl_params: { verify_mode: OpenSSL::SSL::VERIFY_NONE })
