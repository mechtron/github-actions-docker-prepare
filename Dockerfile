FROM alpine:3.12.3
LABEL mechtron <mechtrondev@gmail.com>

RUN apk add --no-cache --upgrade bash
COPY entrypoint.sh /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
