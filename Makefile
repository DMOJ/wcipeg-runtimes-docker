TAG ?= wcipeg-runtimes

.PHONY: all image-tier3 test-tier3

all: image-tier3

image-tier3:
	cd tier3 && docker build -t dmoj/runtimes-tier3 -t dmoj/runtimes-tier3:$(TAG) .

test: test-tier1 test-tier2 test-tier3

test-tier3:
	docker run --rm -v "`pwd`/test":/code --privileged dmoj/runtimes-tier3
