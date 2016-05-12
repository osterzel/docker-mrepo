CONTAINER_NAME := repos
LOCAL_FOLDER := $(shell pwd)/repo

build:
	docker build -t $(CONTAINER_NAME) .

generate_repo: build
	docker run -t -i --rm --name=generate-repos -v $(LOCAL_FOLDER):/mrepo -e VERBOSE=True -e WEB=False $(CONTAINER_NAME)

run_web:
	docker run -t -i --rm --name=software-mirror -v $(LOCAL_FOLDER):/mrepo $(CONTAINER_NAME)
