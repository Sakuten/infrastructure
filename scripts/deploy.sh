#!/bin/bash

function info (){
  echo -e "\033[0;32m-> \033[0m\033[0;01m $1\033[0;0m"
}

script_root=$(dirname $0)

source $script_root/lib/schedule.sh

gen_extension=${1:-10}

cd "${script_root}/.."

info "Generating function.zip"

cd dbgen
make install
make
cd ..

info "Done"

export TF_VAR_dbgen_schedule=$(calc_schedule $gen_extension)

info "DB Data generation is scheduled at: $TF_VAR_dbgen_schedule (+$gen_extension)"

terraform apply

info "All Done!"
