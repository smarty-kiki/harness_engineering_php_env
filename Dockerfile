# harness_engineering_php_env
基于 Debian trixie 的 PHP 开发环境容器

### 环节说明
这个开发环境中含有以下组件
 * nginx
 * mariadb-server
 * redis-server
 * mongodb
 * beanstalkd
 * php-fpm
 * phpunit
 * inotify-tools
 * supervisor
 * wget
 * git
 * composer
 * vim
 * tmux
 * pip
 * mycli
 * claude ( Anthropic CLI )

### 使用方法：

sudo docker run --rm -ti -p 80:80 -p 3306:3306 --name debian_php_dev_env \
      -v {CODE_PATH}:/var/www/{PROJECT_NAME} \
      -v {NGINX_SERVER_CONFIG_FILE}:/etc/nginx/sites-enabled/default \
      -v {SUPERVISOR_CONFIG_FILE}:/etc/supervisor/conf.d/{CONFIG_NAME}.conf \
      kikiyao/harness_engineering_php_env start
