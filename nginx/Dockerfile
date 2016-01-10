FROM nginx

COPY nginx.conf /etc/nginx/nginx.conf
COPY default.conf /etc/nginx/conf.d/default.conf
COPY entrypoint.sh /

RUN mkdir /etc/nginx/ssl
RUN chmod 700 /etc/nginx/ssl

COPY ./ssl/* /etc/nginx/ssl/

COPY landing /usr/share/nginx/html

ENTRYPOINT ["/entrypoint.sh"]
CMD ["nginx", "-g", "daemon off;"]
