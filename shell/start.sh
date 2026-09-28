#!/bin/bash

if  [ -n "$TIMEZONE" ]
then
    cp /usr/share/zoneinfo/$TIMEZONE /etc/localtime
    echo $TIMEZONE >/etc/timezone
fi

if [ -f "$BEFORE_START_SHELL" ]
then
    /bin/bash $BEFORE_START_SHELL
fi

service php8.4-fpm   start > /dev/null &
service nginx        start > /dev/null &
service mariadb      start > /dev/null &
service redis-server start > /dev/null &
service beanstalkd   start > /dev/null &
# clickhouse 的 pid 目录在 tmpfs 下，每次启动都要重建，这一步由 clickhouse 的 init 脚本自己负责
service clickhouse-server start > /dev/null &
service supervisor   start > /dev/null &

wait

if [ -f "$AFTER_START_SHELL" ]
then
    # clickhouse 起来后还要过几秒才接受连接，而 service 只等到进程起来（systemd 下是靠 Type=notify 等的）
    for i in $(seq 1 30)
    do
        clickhouse-client --query 'SELECT 1' > /dev/null 2>&1 && break
        sleep 0.5
    done
    /bin/bash $AFTER_START_SHELL
fi

tmuxinator init
