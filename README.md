# harness_engineering_php_env
PHP 项目的 Harness Engineering 开发环境

## debian_php_dev_env

基于 Debian trixie 的 PHP 开发环境容器

### 包含组件
- nginx
- mariadb-server
- redis-server
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
- claude (Anthropic CLI)

### 使用方法：

```bash
sudo docker run --rm -ti -p 80:80 -p 3306:3306 --name harness_engineering_php_env \\  
        -v ~/.claude:/root/.claude \\  
        -v ~/.claude.json:/root/.claude.json \\  
        -v {CODE_PATH}:/var/www/{PROJECT_NAME} \\  
        -v {NGINX_SERVER_CONFIG_FILE}:/etc/nginx/sites-enabled/default \\  
        -v {SUPERVISOR_CONFIG_FILE}:/etc/supervisor/conf.d/{CONFIG_NAME}.conf \\  
        -e 'PRJ_HOME=/var/www/{PROJECT_NAME}' \\  
        -e 'TIMEZONE=Asia/Shanghai' \\  
        -e 'AFTER_START_SHELL=/var/www/{PROJECT_NAME}/project/after_env_start.sh' \\  
        registry.cn-shenzhen.aliyuncs.com/smarty/harness_engineering_php_env start
```

将本机 claude 配置映射进去来使用配置，非必须  
将项目的 nginx 配置文件映射到指定位置  
指定项目所在容器中的目录  
指定启动时要初始化环境的脚本，如初始化数据库表结构等，非必须  
