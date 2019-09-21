## The Makefile includes instructions on environment setup and lint tests
setup:
	# Setup folder for build
	echo "First setup"
	#mkdir ./go-docker
	cp ./service_hello.go ./go-docker/hello_server.go
	cd /home/ubuntu/udacity/aws-pipeline/go-docker; \
	pwd; \
	go mod init github.com/callicoder/go-docker; \
	go build
	./go-docker/go-docker &
	curl http://localhost:9090?kraut
	pkill go-docker