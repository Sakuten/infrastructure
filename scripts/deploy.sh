#!/bin/bash

function info (){
  echo -e "\033[0;32m-> \033[0m\033[0;01m $1\033[0;0m"
}

gen_extension=${1:-10}

cd "$(dirname $0)/.."

info "Generating function.zip"

cd dbgen
make install
make
cd ..

info "Done"

epoch=$(date +%s)
epoch_target=$((epoch + 60 * $gen_extension))
read year month day hour minute < <(date -d @$epoch_target +'%-Y %-m %-d %-H %-M')

export TF_VAR_dbgen_schedule="cron($minute $hour $day $month ? $year)"

info "DB Data generation is scheduled at: $year/$month/$day $hour:$minute (+$gen_extension)"

terraform apply

info "All Done!"
