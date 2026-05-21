FROM alpine:3.18
RUN apk add --no-cache bash sed
COPY run.sh /run.sh
RUN chmod +x /run.sh
CMD ["/bin/bash", "/run.sh"]
