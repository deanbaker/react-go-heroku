# Build the Go API
FROM golang:latest AS builder
WORKDIR /app/server
ADD server/go.mod server/go.sum ./
RUN go mod download
ADD server/ ./
RUN CGO_ENABLED=0 GOOS=linux GOARCH=amd64 go build -ldflags "-w" -a -o /main .
# Build the React application
FROM node:alpine AS node_builder
COPY client/package.json client/package-lock.json ./
RUN npm install
COPY client/ ./
RUN npm run build
# Final stage build, this will be the container
# that we will deploy to production
FROM alpine:latest
RUN apk --no-cache add ca-certificates
COPY --from=builder /main ./
COPY --from=node_builder /build ./web
RUN chmod +x ./main
EXPOSE 8080
CMD ./main
