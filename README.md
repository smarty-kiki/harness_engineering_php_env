# Harness Engineering PHP Environment
这是一个 PHP 项目的 Harness Engineering 开发环境，方便快速在开发电脑上快速启动一个运行环境并与 claude 进行对话开发，环境中提前告知了 claude 这个开发环境中的各组件安装情况及日志对应位置，并且引导 claude 要自己通过访问项目来测试，查看日志并解决问题，并且自动提交 commit。

## 操作系统简介

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
- chrome_do_action
- chrome_call_your_claude_code

### 快速开始

假设项目名为 `my-app`，代码在本机 `/home/me/projects/my-app`，nginx 配置位于项目内的 `docker/nginx.conf`：

```bash
sudo docker run --rm -ti \
    -p 80:80 \
    -p 3306:3306 \
    -p 12345:12345 \
    -p 12346:12346 \
    --name harness_engineering_php_env \
    -v ~/.claude:/root/.claude \
    -v ~/.claude.json:/root/.claude.json \
    -v /home/me/projects/my-app:/var/www/my-app \
    -v /home/me/projects/my-app/docker/nginx.conf:/etc/nginx/sites-enabled/default \
    -e 'PRJ_HOME=/var/www/my-app' \
    -e 'TIMEZONE=Asia/Shanghai' \
    registry.cn-shenzhen.aliyuncs.com/smarty/harness_engineering_php_env start
```

### 参数说明

| 参数 | 说明 |
|------|------|
| `--rm` | 容器退出后自动删除，不留残留 |
| `-p 80:80` | 将容器的 80 端口（nginx）映射到本机 80 端口 |
| `-p 3306:3306` | 将容器的 3306 端口（MariaDB）映射到本机，方便用本地客户端连接 |
| `-p 12345:12345` | 将容器的 12345 端口（chrome_do_action）映射到本机，方便用本地浏览器插件连接 |
| `-p 12346:12346` | 将容器的 12346 端口（chrome_call_your_claude_code）映射到本机，方便用本地浏览器插件连接 |
| `-v ~/.claude:/root/.claude` | （可选）映射本机 Claude CLI 配置目录，复用本机的对话历史和设置 |
| `-v ~/.claude.json:/root/.claude.json` | （可选）映射本机 Claude CLI 配置文件 |
| `-v {CODE_PATH}:/var/www/{PROJECT_NAME}` | 将项目代码目录挂载进容器 |
| `-v {NGINX_CONF}:/etc/nginx/sites-enabled/default` | 挂载项目的 nginx 站点配置 |
| `-v {SUPERVISOR_CONF}:/etc/supervisor/conf.d/{NAME}.conf` | （可选）挂载项目的 Supervisor 进程管理配置 |
| `-e PRJ_HOME` | 项目在容器内的根目录路径 |
| `-e TIMEZONE` | 容器时区，默认 `Asia/Shanghai` |
| `-e AFTER_START_SHELL` | （可选）容器启动后执行的初始化脚本，如建表、导入测试数据等 |
