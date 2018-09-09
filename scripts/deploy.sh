#!/bin/bash

read year month day hour minute < <(date +'%-Y %-m %-d %-H %-M')

echo "cron($minute $hour $day $month ? $year)"
