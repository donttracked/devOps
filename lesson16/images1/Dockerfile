FROM alpine:latest

RUN apk update && apk add nginx

RUN mkdir -p /opt/www && echo "<h1>Welcome to Nginx on Alpine</h1>" > /opt/www/index.html

COPY nginx.conf /etc/nginx/nginx.conf

EXPOSE 80

CMD ["nginx", "-g", "daemon off;"]
