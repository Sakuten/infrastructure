FILE?=../dbgen_function.zip
DELIVERABLE=${abspath ${FILE}}

${DELIVERABLE}: $(wildcard ./*.py) ids.json install-deps
	-rm ${DELIVERABLE}
	find . -type d -name '.venv' -prune -o -type f -print | zip -q9@ ${DELIVERABLE}
	$(eval VENV = $(shell pipenv --venv))
	cd ${VENV}/lib/python3.6/site-packages && find . -type f -not -name '*.pyc' -print | zip -q9@ ${DELIVERABLE}

.PHONY: install-deps
install-deps: Pipfile Pipfile.lock
	pipenv install
