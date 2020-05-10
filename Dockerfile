FROM wernight/dante

RUN apk add --no-cache bash && \
    apk add --no-cache shadow

COPY etc/sockd.conf /etc/
COPY bin/ /bin/
