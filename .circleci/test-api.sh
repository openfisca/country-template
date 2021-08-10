#! /usr/bin/env bash

apt-get update
apt-get install -y jq

make serve-local &

PORT=5000
ENDPOINT=specs # wrong, to test the --fail option

response=$(curl --retry-connrefused --retry 10 --retry-delay 5 --fail http://127.0.0.1:$PORT/$ENDPOINT | jq -e)


