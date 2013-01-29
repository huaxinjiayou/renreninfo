# coding: utf-8

require 'mysql2'

class RenRenMysql

    def initialize
        @client = Mysql2::Client.new(
            :host => 'localhost',
            :username => 'root',
            :database => 'renren',
            :encoding => 'utf8'
        )
    end

    def query(str)
        @client.query(str)
    end

    # save user info in 10 tables to reduce query stress
    def save_user(id, name, netname)
        name = @client.escape(name)
        netname = @client.escape(netname)

        str = "insert user#{id.to_s.slice(-1)} (userid, name, netname) values (#{id}, '#{name}', '#{netname}')"
        @client.query(str)
        puts str
    end

    def save_relation(owner_id, friend_id)
        @client.query("insert relation (ownerid, friendid) values (#{owner_id}, #{friend_id})")
    end

    def exists(id)
        @client.query("select 1 from user0 where userid = #{id} limit 1;").first
    end
    
end
