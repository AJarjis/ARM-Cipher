FROM arm32v7/gcc:4.9

RUN apt-get update && apt-get install -y \
    vim \
    bash 

COPY ./cipher usr/src/cipher
WORKDIR /usr/src/cipher
RUN make build

ENTRYPOINT [ "/bin/bash" ]