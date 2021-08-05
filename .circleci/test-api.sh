#! /usr/bin/env bash

apt-get update
apt-get install -y jq

make serve-local &

curl --retry-connrefused \
    --retry 5 \
    --retry-delay 20 \
    http://127.0.0.1:5000 --fail

var=$?

if [[ $var -ne 0 ]]
then
  echo "Server failed to start."
  exit $var
fi

response=$(curl --write-out '%{http_code}' --silent --output /dev/null http://127.0.0.1:5000/spec)
if [[ $response -ne 200 ]]
then
  echo "Accessing the swagger endpoint returns an HTTP $response code instead of a 200 code."
  exit 1
fi

curl http://127.0.0.1:5000/spec --fail | jq -e
set var=$?

if [[ $var -ne 0 ]]
then
  echo "The resulting swagger endpoint is not a valid JSON."
  exit $var
fi
