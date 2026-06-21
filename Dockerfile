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
    apt-get install supervisor -y
RUN apt-get install python3-pip -y && \
    apt-get install curl -y

RUN curl -fsSL https://deb.nodesource.com/setup_20.x | bash -
RUN apt install -y nodejs

RUN npm install -g @anthropic-ai/claude-code@2.1.153

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

EXPOSE 80 3306

CMD start
