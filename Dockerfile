# Dockerfile References: https://docs.docker.com/engine/reference/builder/

# Start from the latest golang image
FROM golang:latest

# Add Maintainer Info
LABEL maintainer="Craig V <csvrandom@gmail.com>"

# Set the Current Working Directory inside the container
WORKDIR /app

# Copy go mod and sum files
COPY ./go-docker/go.mod ./go-docker/go.sum ./

# Download all dependencies. Dependencies will be cached if the go.mod and go.sum files are not changed
RUN go mod download

# Copy the source from the current directory to the Working Directory inside the container
COPY ./go-docker .

# Build the Go appdic=
RUN go build -o main .

# Expose port 9090 to the outside world
EXPOSE 9090

# Command to run the executable
CMD ["./main"]