#! /usr/bin/env bash

make serve-local &

PORT=5000
ENDPOINT=spec

curl --retry-connrefused --retry 10 --retry-delay 5 --fail http://127.0.0.1:$PORT/$ENDPOINT | python -m json.tool
