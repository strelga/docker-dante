FROM wernight/dante

ARG USERNAME
ARG PASSWORD

RUN printf "${PASSWORD}\n${PASSWORD}\n" | adduser ${USERNAME}
