当前项目的请求地址是 http://127.0.0.1/  

该项目相关的运行环境的日志文件如下：  
Nginx 请求日志：/var/log/nginx/access.log  
Nginx 报错日志：/var/log/nginx/error.log  
PHP-FPM 日志：/var/log/php-fpm.log  
MySQL 报错日志：/var/log/mysql/error.log  
MySQL 慢查询日志：/var/log/mysql/slow.log  
MySQL SQL 日志：/var/log/mysql/mysql.log  Redis 日志：/var/log/redis/redis-server.log  
Redis 执行命令日志：/var/log/redis/redis-cli.log  

如果项目有用 frame 框架，frame 框架实现中项目的日志文件如下：  
框架截获的异常的日志：/tmp/php_exception.log  
框架中的提醒日志：/tmp/php_notice.log  
框架中的模块打印日志：/tmp/php_module.log  

如果我说让你自己测试一下，你就通过访问对应功能的 URL 来测试，检查输出结果，如果报错了，就检查报错日志自己开始修复  
如果你修复问题时修改到了 Nginx、MySQL、PHP-FPM、Redis 的配置文件，可以用 service 命令来重启重新加载配置文件，这个环境里是用的 mariadb 来代替的 MySQL，如下示例：  
service php8.4-fpm   restart  
service nginx        restart  
service mariadb      restart  
service redis-server restart  
service beanstalkd   restart  
service supervisor   restart  

当你修改完代码后，自己将项目中所有改动添加到 git 管理范围，可执行 git add --all 命令来添加，并生成一个 commit message 来提交 commit，message 要遵循规则：  
message 为四段结构，列出来新增了什么功能、修改了什么功能、删除了什么功能、修复了什么问题，没有的段落就不用写，不是讲文件名，而是讲什么功能什么问题  
在 commit 时，临时定义 Author 身份，如 git commit -m "" --author="Harness Developer <harness@yao-yang.cn>"  
