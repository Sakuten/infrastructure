#!/bin/bash

script_root=$(dirname $0)

source $script_root/lib/schedule.sh

exclude_targets=$(echo $@ | sed -e 's/\./\\./g' | tr ' ' '|')

export TF_VAR_dbgen_schedule=$(calc_schedule $gen_extension)
terraform destroy $(for r in `terraform state list | egrep -v "$exclude_targets"` ; do printf -- "-target ${r} "; done)
