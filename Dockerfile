FROM golang:1.17 AS builder

WORKDIR /httpserver
COPY . .
RUN go mod download
RUN CGO_ENABLED=0 go build -o httpserver .

FROM alpine:3.10
COPY --from=builder /httpserver/httpserver /
EXPOSE 8080
CMD ["/httpserver"]
