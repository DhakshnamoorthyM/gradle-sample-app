.PHONY: build deploy docker
SHELL := /bin/bash
.ONESHELL:

build:
  @echo "Build Application"
  ./gradlew war
