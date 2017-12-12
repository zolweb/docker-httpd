FROM httpd:2.4-alpine

# Install tzdata and change to Europe/Paris
RUN  set -x && \
    apk --update add \
    tzdata \
    logrotate \
    && ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime \
    && rm -rf /var/cache/apk/*

COPY apache/httpd.conf /usr/local/apache2/conf/extra/httpd-vhosts.conf

# Custom logrotate configuration for nginx
ADD logrotate/apache /etc/logrotate.d/apache
ADD logrotate/cron /etc/periodic/daily/logrotate-cron

# Custom entry point
ADD scripts/start.sh /var/www/start.sh

RUN chmod 0777 /var/www/start.sh \
  && chmod +x /etc/periodic/daily/logrotate-cron \
  && sed -i 's/^Listen 80/Listen 8080/' "/usr/local/apache2/conf/httpd.conf"

EXPOSE 8080

WORKDIR /var/www/public
CMD ["/var/www/start.sh"]