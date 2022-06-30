FROM nginx:1.22.0-alpine

ENV DEVOPS musabeksadullaev

COPY ./info.html /usr/share/nginx/html/info.html

COPY ./generate.sh /app/generate.sh

CMD ["/bin/sh", "-c", "/app/generate.sh && nginx -g 'daemon off;'"]
