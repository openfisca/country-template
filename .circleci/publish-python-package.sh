#! /usr/bin/env bash

twine upload dist/* --username $PYPI_USERNAME --password $PYPI_PASSWORD  # publish
