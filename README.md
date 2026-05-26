# harness_engineering_php_env
PHP 项目的 Harness Engineering 开发环境

## debian_php_dev_env

基于 Debian trixie 的 PHP 开发环境容器

### 包含组件
- nginx
- mariadb-server
- redis-server
- mongodb
- beanstalkd
- php8.4-fpm
- phpunit
- inotify-tools
- supervisor
- wget
- git
- composer
- vim
- tmux
- pip
- mycli
- claude (Anthropic CLI)

### 使用方法：

sudo docker run --rm -ti -p 80:80 -p 3306:3306 --name harness_engineering_php_env \
         -v {CODE_PATH}:/var/www/{PROJECT_NAME} \
         -v {NGINX_SERVER_CONFIG_FILE}:/etc/nginx/sites-enabled/default \
         -v {SUPERVISOR_CONFIG_FILE}:/etc/supervisor/conf.d/{CONFIG_NAME}.conf \
         -e 'PRJ_HOME=/var/www/api_frame' \
         -e 'ENV=development' \
         -e 'TIMEZONE=Asia/Shanghai' \
         -e 'AFTER_START_SHELL=/var/www/api_frame/project/tool/development/after_env_start.sh' \
         registry.cn-shenzhen.aliyuncs.com/smarty/harness_engineering_php_env start
