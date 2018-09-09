FILE?=../dbgen_function.zip
DELIVERABLE=${abspath ${FILE}}

${DELIVERABLE}: $(wildcard ./*.py) ids.json Pipfile.lock
	-rm ${DELIVERABLE}
	zip -qr9 ${DELIVERABLE} ./
	$(eval VENV = $(shell pipenv --venv))
	cd ${VENV}/lib/python3.6/site-packages && zip -qr9 ${DELIVERABLE} ./

Pipfile.lock: Pipfile
	pipenv install

