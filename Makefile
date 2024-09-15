IMAGE_NAME=bikashpdash/searchengine
CONTAINER_NAME=searchengine
build_image: ## Build the docker image
	docker build -t $(IMAGE_NAME) . ;

run_docker: ## Run the docker image
	docker run --rm --name $(CONTAINER_NAME) -v /tmp:/tmp  -p 8000:8000 $(IMAGE_NAME)

pb_codegen: ## Generate the protobuf code
	protoc --proto_path=./protos --python_out=./searchengine/pb protos/documents.proto ;

run: ## Run the app locally
	python searchengine/main.py
	
dummy_index: ## Index dummy data
	docker run --rm -it -v /tmp:/tmp $(IMAGE_NAME) python3 searchengine/script.py i

help:
	@fgrep -h "##" $(MAKEFILE_LIST) | fgrep -v fgrep | sed -e 's/\\$$//' | sed -e 's/##//';
