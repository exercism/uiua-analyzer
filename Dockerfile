FROM rust:1.82.0-alpine3.20 AS builder

RUN apk add --no-cache linux-headers make musl-dev

RUN cargo install --git https://github.com/uiua-lang/uiua --rev aa6310c uiua

FROM alpine:3.20

RUN apk add --no-cache jq

COPY --from=builder /usr/local/cargo/bin/uiua /usr/local/bin

WORKDIR /opt/analyzer
COPY . .
ENTRYPOINT ["/opt/analyzer/bin/run.sh"]
