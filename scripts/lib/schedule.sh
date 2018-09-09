function calc_schedule() {
  local gen_extension=${1:-10}
  local epoch=$(date +%s)
  local epoch_target=$((epoch + 60 * $gen_extension))
  read year month day hour minute < <(date -u -d @$epoch_target +'%-Y %-m %-d %-H %-M')
  echo "cron($minute $hour $day $month ? $year)"
}
