# Stage 1: Build the Go application
FROM golang:1.21 AS builder

WORKDIR /app

COPY go.mod ./
RUN go mod download

COPY . .
RUN go build -o hello-api .

# Stage 2: Create a lightweight runtime image
FROM alpine:latest

WORKDIR /root/

RUN apk --no-cache add ca-certificates
COPY --from=builder /app/hello-api .

EXPOSE 8080

CMD ["./hello-api"]