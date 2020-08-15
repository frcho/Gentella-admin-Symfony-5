ARG VERSION

# Dev image
FROM nginx:${VERSION}-alpine as dev

# Copy nginx config
COPY .docker/nginx/nginx.conf /etc/nginx/nginx.conf

# # Configure a healthcheck to validate that everything is up&running
# HEALTHCHECK --timeout=10s CMD curl --silent --fail http://127.0.0.1:8080/fpm-ping


# Prod image
FROM dev as prod

# Copy assets
# COPY ./assets /app/public