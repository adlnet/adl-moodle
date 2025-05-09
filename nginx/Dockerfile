FROM nginx:alpine

ARG HOSTNAME
ARG CONF_FILE=localDev.conf

# Move our configuration into place
#
RUN rm /etc/nginx/nginx.conf
COPY $CONF_FILE /etc/nginx/nginx.conf

# Swap our environment variables
#
RUN cat /etc/nginx/nginx.conf | envsubst '$HOSTNAME' | tee /tmp/nginx.conf
RUN mv /tmp/nginx.conf /etc/nginx/nginx.conf

