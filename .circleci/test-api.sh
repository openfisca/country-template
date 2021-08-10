#! /usr/bin/env bash

apt-get update
apt-get install -y jq

openfisca serve --country-package openfisca_country_template &

PORT=5000
ENDPOINT=spec

set -e
curl --retry-connrefused --retry 10 --retry-delay 5 --fail http://127.0.0.1:$PORT/$ENDPOINT | jq -e