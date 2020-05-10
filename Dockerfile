FROM wernight/dante

RUN apk add --no-cache bash

COPY etc/sockd.conf /etc/
COPY bin/ /bin/
