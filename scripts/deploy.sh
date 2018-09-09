#!/bin/bash

set -e

script_root=$(dirname $0)

source $script_root/lib/schedule.sh
source $script_root/lib/log.sh

gen_extension=${1:-10}

cd "${script_root}/.."

info "Generating dbgen_function.zip"

cd dbgen
make
cd ..

info "Done"

export TF_VAR_dbgen_schedule=$(calc_schedule $gen_extension)

info "DB Data generation is scheduled at: $TF_VAR_dbgen_schedule (+$gen_extension)"

terraform apply

info "All Done!"
