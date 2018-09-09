FILE?=./function.zip
DELIVERABLE=${abspath ${FILE}}

${DELIVERABLE}: $(wildcard ./*.py) Pipfile.lock
	-rm ${DELIVERABLE}
	zip -r9 ${DELIVERABLE} ./
	$(eval VENV = $(shell pipenv --venv))
	cd ${VENV}/lib/python3.6/site-packages && zip -r9 ${DELIVERABLE} ./

Pipfile.lock: Pipfile
	pipenv install

