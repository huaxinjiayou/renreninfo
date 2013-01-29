# coding: utf-8

require 'redis'

class Cache

    def initialize
        @redis = Redis.new
    end

    def set(id, val)
        @redis.set(id, val)
    end

    def get(id)
        @redis.get(id)
    end

    def del(id)
        @redis.del(id)
    end

    def exists(id)
        @redis.exists(id)
    end

    def destory
        @redis.flushall
    end
end
