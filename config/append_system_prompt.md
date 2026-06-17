当前项目的请求地址是 http://127.0.0.1/  

与项目相关的组件的日志文件如下：  
Nginx 请求日志：/var/log/nginx/access.log  
Nginx 报错日志：/var/log/nginx/error.log  
PHP-FPM 日志：/var/log/php-fpm.log  
MySQL 报错日志：/var/log/mysql/error.log  
MySQL 慢查询日志：/var/log/mysql/slow.log  
MySQL SQL 日志：/var/log/mysql/mysql.log  
Redis 日志：/var/log/redis/redis-server.log  
Redis 执行命令日志：/var/log/redis/redis-cli.log  
chrome_do_action 日志：/tmp/chrome/supervisor-\*.log  

chrome_do_action 是一个允许你操作浏览器来测试页面的工具，页面测试优先使用 chrome_do_action，测试完后把测试过程中打开的页面关掉，当没有浏览器在线时才用 curl 命令做临时替代，具体的工具说明可以看 /var/www/chrome_do_action/cli/CLAUDE.md 文件来学习  
接口 API 测试才用 curl 命令来测试  

如果项目有用 frame 框架，frame 框架实现中项目的日志文件如下：  
框架截获的异常的日志：/tmp/php_exception.log  
框架中的提醒日志：/tmp/php_notice.log  
框架中的模块打印日志：/tmp/php_module.log  
框架中队列 worker 会让 supervisor 来进行守护，所以队列的输出会记录在 /var/log/supervisor/\*.log 中  

如果我说让你自己测试一下，你就通过访问对应功能的 URL 来测试，检查输出结果，如果报错了，就检查报错日志自己开始修复  
如果你修复问题时修改到了 Nginx、MySQL、PHP-FPM、Redis 的配置文件，可以用 service 命令来重启重新加载配置文件，这个环境里是用的 mariadb 来代替的 MySQL，如下示例：  
service php8.4-fpm   restart  
service nginx        restart  
service mariadb      restart  
service redis-server restart  
service beanstalkd   restart  
service supervisor   restart  

当你修改完代码后，自己将项目中所有改动添加到 git 管理范围，可执行 git add --all 命令来添加，并生成一个 commit message 来提交 commit，message 要遵循规则：  
message 为四段结构，列出来新增了什么功能、修改了什么功能、删除了什么功能、修复了什么问题，没有的段落就不用写，不是讲文件名，而是讲什么功能什么问题，message 格式要遵循盘古之白原则  
在 commit 时，临时定义 Author 身份，如 git commit -m "" --author="Harness Developer <harness@yao-yang.cn>"  
