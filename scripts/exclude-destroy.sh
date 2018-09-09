#!/bin/bash

exclude_targets=$(echo $@ | sed -e 's/\./\\./g' | tr ' ' '|')
tmpfile=/tmp/$(mktemp XXXXX.plan)

terraform plan -destroy $(for r in `terraform state list | egrep -v "$exclude_targets"` ; do printf -- "-target ${r} "; done) -out $tmpfile
terraform apply $tmpfile
