# coding: utf-8

require_relative 'mysql'
require_relative 'cache'

def create_talbe
    mysql = RenRenMysql.new
    index = 0;
    while index < 10
        query = "drop table `user#{index}`;"
        mysql.query(query) rescue puts "no table user#{index}, will be created"

        query = "create table `user#{index}`(
            `userid` bigint(11) not null,
            `name` varchar(256) collate utf8_bin,
            `netname`  varchar(256) collate utf8_bin,
            `qq` varchar(256) collate utf8_bin,
            `mail` varchar(256) collate utf8_bin,
            `msn` varchar(256) collate utf8_bin,
            `web` varchar(256) collate utf8_bin,
            `sex` tinyint(1) default 1,
            `birthday` datetime,
            `allinfo` text collate utf8_bin,
            `isUse` tinyint(1) default 0,
            `time` timestamp not null default current_timestamp
            )ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;"
        mysql.query(query)
        puts "create table user#{index}"

        index += 1
    end

    query = "drop table `relation`;"
    mysql.query(query) rescue puts "no table relation, will be created"

    query = "create table `relation`(
        `ownerid` bigint(11) not null,
        `friendid` bigint(11) not null
        )ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;"
    mysql.query(query)
    puts "create table relation"
end
cache = Cache.new
cache.destory
puts "clear cache"

create_talbe()
