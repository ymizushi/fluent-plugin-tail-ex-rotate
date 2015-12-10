# fluent-plugin-tail-ex-rotate

fluent-plugin-tail-ex-rotate is a fluentd plugin to delay file lotation time.

## Install

```sh
gem install fluent-plugin-tail-ex-rotate
```

## Test

```sh
bundle install
rake test
```

## Setting

The setting of fluent-plugin-tail-ex-rotate is roughly the same with in_tail built-in plugin.
Difference between fluent-plugin-tail-ex-rotate and in_tail built-in plugin setting are :expand_rotate_time attribute.

:expand_rotate_time attribute must be set number of seconds.

For example,
```xml
<source>
  type tail_ex_rotate
  path /var/log/httpd/access_log.%Y%m%d
  tag access_process_time
  pos_file /var/log/td-agent/httpd-access.log.pos
  time_format %d/%b/%Y:%H:%M:%S %z
  expand_rotate_time 18000s
  types process_time:integer
</source>
```

Daily file lotation starts with 05:00 beacause of this setting.
