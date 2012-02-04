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
```

```
<source>
  type mysql_slow_query
  path /path/to/mysqld-slow.log
  tag mysqld.slow_query
</source>
```

##Expected record format

Sample

```
# Time: 111003 14:17:38
# User@Host: root[root] @ localhost []
# Query_time: 0.000270  Lock_time: 0.000097 Rows_sent: 1  Rows_examined: 0
SET timestamp=1317619058;
SELECT * FROM life;
```

Then following JSON is going to be made.

```json
{
    "time": "2011-10-03 14:17:38",
    "user": "root[root]",
    "host": "localhost []",
    "query_time": 0.000270,
    "lock_time": 0.000097,
    "rows_sent": 1,
    "rows_examined": 0,
    "sql":  "select * from life;"
}
```
