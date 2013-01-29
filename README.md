### 作用

* ruby1.9.3
* 通过人人网线上接口获取全部用户关系链
* 依赖的gem json, [mechanize](https://github.com/sparklemotion/mechanize), [redis](https://github.com/redis/redis-rb), [mysql2](https://github.com/brianmario/mysql2)
* 通过mysql.rb进行简单的配置，执行prepare.rb进行简单的初始化, ruby start.rb 用户名，密码 启动程序

### TODO
* 提高效率, 减少mysql查询操作