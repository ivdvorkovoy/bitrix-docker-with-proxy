FROM nginx:latest

ARG SSL_MODE="disable"
ENV SSL_MODE=${SSL_MODE}

COPY ./conf/nginx.conf /etc/nginx/
COPY ./conf/ssl-$SSL_MODE.conf /etc/nginx/conf.sites/default.conf
COPY ./conf/includes /etc/nginx/conf.includes
COPY ./ssl /etc/nginx/ssl

EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
