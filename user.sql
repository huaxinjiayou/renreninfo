create table `user`(
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
)ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

create table `relation`(
    `ownerid` bigint(11) not null,
    `friendid` bigint(11) not null
)ENGINE=MyISAM DEFAULT CHARSET=utf8 COLLATE=utf8_bin;