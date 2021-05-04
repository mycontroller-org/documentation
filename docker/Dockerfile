FROM nginx:1.20.0-alpine

LABEL maintainer="Jeeva Kandasamy <jkandasa@gmail.com>"

ENV DATA_HOME="/usr/share/nginx/html"

EXPOSE 80

# install timzone utils
RUN apk --no-cache add tzdata

# copy Web UI files
COPY ./public /usr/share/nginx/html
