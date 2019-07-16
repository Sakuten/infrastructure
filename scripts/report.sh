#!/bin/bash

set -euo pipefail

cd "$(dirname $0)/.."

function terraform_version() {
    local raw_out="$(terraform version)"
    local tf_version="$(head -1 <<< $raw_out)"
    local provider_version="$(grep + <<< $raw_out)"

    echo " * $tf_version"
    echo "$provider_version" | sed "s/^/  /"
}

function tfenv_version() {
    echo " * $(tfenv --version)"
}

function main() {
    echo " * commit $(git rev-parse --short HEAD)"
    echo " * dbgen/backend $(cd dbgen/backend; git rev-parse --short HEAD)"
    terraform_version
    tfenv_version
}

main
