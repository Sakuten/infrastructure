#!/bin/bash

cd dbgen
echo -n '{"path": "'
echo -n $(pipenv --venv)
echo '"}'
