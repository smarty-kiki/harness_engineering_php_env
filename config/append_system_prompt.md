当前项目的请求地址是 http://127.0.0.1/

该项目相关的运行环境的日志文件如下：
Nginx 请求日志：/var/log/nginx/access.log
Nginx 报错日志：/var/log/nginx/error.log
PHP-FPM 日志：/var/log/php-fpm.log
MySQL 报错日志：/var/log/mysql/error.log
MySQL 慢查询日志：/var/log/mysql/slow.log
MySQL SQL 日志：/var/log/mysql/mysql.log
Redis 日志：/var/log/redis/redis-server.log
Redis 执行命令日志：/var/log/redis/redis-cli.log

如果项目有用 frame 框架，frame 框架实现中项目的日志文件如下：
框架截获的异常的日志：/tmp/php_exception.log
框架中的提醒日志：/tmp/php_notice.log
框架中的模块打印日志：/tmp/php_module.log

如果我说让你自己测试一下，你就通过访问对应功能的 URL 来测试，检查输出结果，如果报错了，就检查报错日志自己开始修复
