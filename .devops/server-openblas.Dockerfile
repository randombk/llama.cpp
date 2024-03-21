ARG UBUNTU_VERSION=22.04

FROM ubuntu:$UBUNTU_VERSION as build

RUN apt-get update && \
    apt-get install -y build-essential git libopenblas-dev

WORKDIR /app

COPY . .

RUN make LLAMA_OPENBLAS=1

FROM ubuntu:$UBUNTU_VERSION as runtime

COPY --from=build /app/server /server

ENV LC_ALL=C.utf8

ENTRYPOINT [ "/server" ]
