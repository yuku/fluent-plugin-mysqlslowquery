#fluent-plugin-mysqlslowquery

Fluent input plugin for  MySQL slow query log file.

##Installation

```shell
% gem install fluent-plugin-mysqlslowquery
```

##How to use

Edit conf file.

```conf
#/etc/fluentd/fluent.conf
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

Record

```json
{
    "user": "root[root]",
    "host": "localhost",
    "host_ip": "",
    "query_time": 0.000270,
    "lock_time": 0.000097,
    "rows_sent": 1,
    "rows_examined": 0,
    "sql": "SET timestamp=1317619058; SELECT * FROM life;"
}
```
