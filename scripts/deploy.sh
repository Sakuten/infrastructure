#!/bin/bash

epoch=$(date +%s)
epoch_target=$((epoch + 60 * 10))
read year month day hour minute < <(date -d @$epoch_target +'%-Y %-m %-d %-H %-M')

echo "cron($minute $hour $day $month ? $year)"
