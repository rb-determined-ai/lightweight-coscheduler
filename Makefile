all: push

build:
	docker build . -t rbdai/lightweight-coscheduler

push: build
	docker push rbdai/lightweight-coscheduler
