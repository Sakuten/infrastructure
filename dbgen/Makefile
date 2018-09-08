DELIVERABLE?=./function.zip

${DELIVERABLE}: $(wildcard ./*)
	zip -r9 ${DELIVERABLE} ./*
	$(eval VENV = $(shell pipenv --venv))
	cd ${VENV}/lib/python3.6/site-packages && zip -r9 ${DELIVERABLE} ./*

.PHONY: install
install:
	pipenv install

