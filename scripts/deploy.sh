#!/bin/bash

function strip_num() {
  echo $@ | sed -e 's/^0*\([0-9]\+\)$/\1/g'
}


year=$(date +%Y)
month=$(strip_num $(date +%m))
day=$(strip_num $(date +%d))

hour=$(strip_num $(date +%H))
minute=$(strip_num $(date +%M))

echo "cron($minute $hour $day $month ? $year)"
