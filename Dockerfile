# Everything from here until WORKDIR should be kept in sync with the test runner.
FROM rust:1.99.0-alpine3.23@sha256:42c2519fdf75d9e34cc61a1aaf34b1a684da9bfd65fe5daefef98d92a801b001 AS builder

RUN apk add --no-cache linux-headers make musl-dev

RUN cargo install uiua@0.18.1

FROM alpine:3.24.3@sha256:be2656061b536c1883c4034790e21d0a09c5aaaf51968b89368a3c0371ea2c9a

RUN apk add --no-cache jq

COPY --from=builder /usr/local/cargo/bin/uiua /usr/local/bin
# Everything until here should be kept in sync with the test runner.

WORKDIR /opt/analyzer
COPY . .
ENTRYPOINT ["/opt/analyzer/bin/run.sh"]
