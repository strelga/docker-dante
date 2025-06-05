FROM wernight/dante

RUN apk add --no-cache bash && \
    apk add --no-cache shadow

COPY bin/ /bin/
