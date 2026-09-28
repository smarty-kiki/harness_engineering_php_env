FROM debian

# 构建环境带 tty 时，clickhouse 的 postinst（clickhouse install）会因为在 tty 上等密码输入而卡死构建，
# 它只在 stdout 是 tty 且 DEBIAN_FRONTEND 不是 noninteractive 时才去读密码，这里统一声明为非交互
ARG DEBIAN_FRONTEND=noninteractive

RUN apt-get update && \
    apt-get install apt-utils -y && \
    apt-get upgrade -y && \
    apt-get install nginx -y && \
    apt-get install mariadb-server -y && \
    apt-get install redis-server -y && \
    apt-get install beanstalkd -y
RUN apt-get install php8.4-fpm -y && \
    apt-get install php8.4-redis -y && \
    apt-get install php8.4-curl -y && \
    apt-get install php8.4-mysql -y && \
    apt-get install php8.4-mongodb -y && \
    apt-get install php8.4-xml -y && \
    apt-get install php8.4-mbstring -y && \
    apt-get install php8.4-yaml -y && \
    apt-get install php8.4-dev -y && \
    apt-get install php8.4-zip -y && \
    apt-get install php8.4-gd -y
RUN apt-get install phpunit -y && \
    apt-get install inotify-tools -y && \
    apt-get install wget -y && \
    apt-get install gnupg -y && \
    apt-get install zip -y && \
    apt-get install git -y && \
    apt-get install composer -y && \
    apt-get install vim -y && \
    apt-get install tmux -y && \
    apt-get install tmuxinator -y && \
    apt-get install supervisor -y
RUN apt-get install python3-pip -y && \
    apt-get install curl -y

# clickhouse 需要先导入官方源与签名密钥（curl、gnupg 要到上面一层才装好）
RUN curl -fsSL 'https://packages.clickhouse.com/rpm/lts/repodata/repomd.xml.key' | gpg --dearmor -o /usr/share/keyrings/clickhouse-keyring.gpg && \
    echo "deb [signed-by=/usr/share/keyrings/clickhouse-keyring.gpg arch=$(dpkg --print-architecture)] https://packages.clickhouse.com/deb lts main" > /etc/apt/sources.list.d/clickhouse.list && \
    printf '#!/bin/sh\nexit 101\n' > /usr/sbin/policy-rc.d && \
    chmod +x /usr/sbin/policy-rc.d && \
    apt-get update && \
    apt-get install clickhouse-server -y && \
    apt-get install clickhouse-client -y && \
    rm -f /usr/sbin/policy-rc.d

# 没有 systemd，靠 deb 自带的 /etc/init.d/clickhouse-server 启动，配置一律用 config.d 覆盖
RUN mkdir -p /etc/clickhouse-server/config.d
COPY ./config/clickhouse_config.xml /etc/clickhouse-server/config.d/harness.xml

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt install -y nodejs

RUN npm install -g @anthropic-ai/claude-code@v2.1.217

COPY ./shell/start.sh /bin/start
RUN chown root:root /bin/start && \
    chmod +x /bin/start

COPY ./config/bashrc /root/.bashrc
COPY ./config/append_system_prompt.md /root/.append_system_prompt.md
COPY ./config/tmux.conf /root/.tmux.conf

RUN mkdir -p /root/.tmuxinator
COPY ./config/tmuxinator_init.yml /root/.tmuxinator/init.yml

RUN git clone https://github.com/smarty-kiki/chrome_do_action.git /var/www/chrome_do_action
RUN cd /var/www/chrome_do_action/server && npm install && npm run build
RUN cd /var/www/chrome_do_action/cli && npm install && npm run build && npm link

RUN git clone https://github.com/smarty-kiki/chrome_call_your_claude_code /var/www/chrome_call_your_claude_code
RUN cd /var/www/chrome_call_your_claude_code/server && npm install

COPY ./shell/config_init.sh /tmp/config_init.sh
RUN /bin/bash /tmp/config_init.sh

ENV LC_ALL C.UTF-8

EXPOSE 80 3306 8123 12345 12346

CMD start
