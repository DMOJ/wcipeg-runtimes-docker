TAG ?= latest

.PHONY: all image-tier1 image-tier2 image-tier3 test-tier1 test-tier2 test-tier3

all: image-tier1 image-tier2 image-tier3

image-tier1:
	cd tier1 && docker build -t dmoj/runtimes-tier1 -t dmoj/runtimes-tier1:$(TAG) .

image-tier2: image-tier1
	cd tier2 && docker build -t dmoj/runtimes-tier2 -t dmoj/runtimes-tier2:$(TAG) .

image-tier3: image-tier2
	cd tier3 && docker build -t dmoj/runtimes-tier3 -t dmoj/runtimes-tier3:$(TAG) .

test: test-tier1 test-tier2 test-tier3

test-tier1:
	docker run --rm -v "`pwd`/test":/code --privileged --cap-add=SYS_PTRACE dmoj/runtimes-tier1

test-tier2:
	docker run --rm -v "`pwd`/test":/code --cap-add=SYS_PTRACE dmoj/runtimes-tier2

test-tier3:
	docker run --rm -v "`pwd`/test":/code --cap-add=SYS_PTRACE dmoj/runtimes-tier3
