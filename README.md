#fluent-plugin-mysqlslowquery

Fluent input plugin for  MySQL slow query log file.

##How to use

Puts in_mysql_slow_query.rb to plugin directory.

```shell
% cp in_mysql_slow_query.rb path/to/fluent/plugin
```

Edit setting file.

```shell
% edit fluent.conf

<source>
type mysql_slow_query
path /path/to/mysqld-slow.log
tag mysqld.slow_query
</source>
```
