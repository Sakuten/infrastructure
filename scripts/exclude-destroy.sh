#!/bin/bash

exclude_targets=$(echo $@ | sed -e 's/\./\\./g' | tr ' ' '|')

terraform destroy $(for r in `terraform state list | egrep -v "$exclude_targets"` ; do printf -- "-target ${r} "; done)
