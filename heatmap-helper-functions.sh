#!/bin/bash

######
# Reduce the precision to 1 decimal point == 11Km
# Requires BC (shell calculator)
function geo_reduce {
  local PRECISION=1
  
  local LAT=$(echo "$1" | cut -d',' -f2)
  local LON=$(echo "$1" | cut -d',' -f1)

  local RLAT=$(echo "scale=${PRECISION}; ${LAT}/1.0" | bc -l)
  local RLON=$(echo "scale=${PRECISION}; ${LON}/1.0" | bc -l)

  echo "$RLAT $RLON"
}

######
# Apply the geo_reduce function to a file, line by line
#
# csv_geo_reduce <FILE>
function csv_geo_reduce {
  for LINE in $(cat $1); do
    geo_reduce "$LINE"
  done
}

######
# Convert a CSV to input JSON
#
function as_json {
  cat $* | awk '{print "{\"lat\":"$2",\"lng\":"$3",\"value\":"$1"}" }'
}
