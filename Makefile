.PHONY: build deploy docker
SHELL := /bin/bash
.ONESHELL:

build:
	@echo "Build Application"
	chmod +x gradlew
	./gradlew war
