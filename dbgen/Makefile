FILE?=../dbgen_function.zip
DELIVERABLE=${abspath ${FILE}}

${DELIVERABLE}: $(wildcard ./*.py) ids.json install-deps
	-rm ${DELIVERABLE}
	zip -qr9 ${DELIVERABLE} ./
	$(eval VENV = $(shell pipenv --venv))
	cd ${VENV}/lib/python3.6/site-packages && zip -qr9 ${DELIVERABLE} ./

.PHONY: install-deps
install-deps: Pipfile Pipfile.lock
	pipenv install

