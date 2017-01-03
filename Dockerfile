# Pull base image.
FROM resin/rpi-raspbian:jessie

# Bring in our compiled package
COPY build/nginx_1.11.8-1~jessie_armhf.deb /tmp/

# Install nginx from registry and replace it with newer version
RUN \
    apt-get update && \
    apt-get install -y nginx && \
    dpkg -i --force-overwrite /tmp/nginx_1.11.8-1~jessie_armhf.deb && \
    apt-get autoremove -y && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/* && \
    rm -f /tmp/nginx_1.11.8-1~jessie_armhf.deb && \
    echo "\ndaemon off;" >> /etc/nginx/nginx.conf

# Define mountable directories.
VOLUME ["/etc/nginx/sites-enabled", "/etc/nginx/certs", "/etc/nginx/conf.d", "/var/www/html"]

# Expose ports.
EXPOSE 80
EXPOSE 443

# forward request and error logs to docker log collector
RUN ln -sf /dev/stdout /var/log/nginx/access.log \
    && ln -sf /dev/stderr /var/log/nginx/error.log

# Define default command.
CMD ["nginx"]
