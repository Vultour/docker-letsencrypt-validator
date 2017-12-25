FROM alpine:3.6

COPY ./variables.sh /srv/variables.sh
COPY ./entrypoint.sh /srv/entrypoint.sh
RUN apk add --no-cache certbot && chmod +x /srv/entrypoint.sh
CMD /srv/entrypoint.sh
