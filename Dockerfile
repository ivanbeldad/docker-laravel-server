FROM debian:jessie

LABEL maintainer="ivandelabeldad@gmail.com"

ADD ./dockerfiles/* /dockerfiles/
WORKDIR /app
EXPOSE 80

RUN echo "deb http://packages.dotdeb.org jessie all" >> /etc/apt/sources.list && \
    apt-get update && apt-get install -y wget && \
    wget "https://www.dotdeb.org/dotdeb.gpg" && apt-key add dotdeb.gpg && \
    apt-get update && \
    apt-get install -y php7.0 apache2 && \
    a2enmod rewrite && \
    rm -f /etc/apache2/sites-available/000-default.conf && \
    cp /dockerfiles/000-default.conf /etc/apache2/sites-available/000-default.conf && \
    service apache2 stop

CMD ["/usr/sbin/apache2ctl", "-D", "FOREGROUND"]
