FROM debian

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
    apt-get install supervisor -y && \
    apt-get install toilet -y
RUN apt-get install python3-pip -y && \
    pip install mycli

# Install Claude CLI
RUN curl -fsSL https://github.com/anthropics/claude-code/releases/latest/download/claude-linux-arm64 -o /usr/local/bin/claude && \
    chmod +x /usr/local/bin/claude

COPY ./shell/start.sh /bin/start
RUN chown root:root /bin/start && \
    chmod +x /bin/start

COPY ./config/bashrc /root/.bashrc
COPY ./config/tmux.conf /root/.tmux.conf

RUN mkdir -p /root/.tmuxinator
COPY ./config/tmuxinator_init.yml /root/.tmuxinator/init.yml

COPY ./shell/config_init.sh /tmp/config_init.sh
RUN /bin/bash /tmp/config_init.sh

ENV LC_ALL C.UTF-8

EXPOSE 80 3306

CMD start
