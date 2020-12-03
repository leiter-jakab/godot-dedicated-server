FROM golang:alpine as builder

WORKDIR /go/src/matchmaking
COPY src .

RUN apk --no-cache add git \
    && go get -d -v ./... \
    && go install -v ./... \
    && go build

FROM alpine

RUN addgroup matchmaker \
    && adduser -G matchmaker -D matchmaker

COPY --from=builder --chown=matchmaker:matchmaker /go/src/matchmaking/matchmaking /matchmaking

CMD ["/matchmaking"]