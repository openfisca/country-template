#!/bin/sh

set -e

if ./detect-functional-changes.sh
then
    python setup.py bdist_wheel  # build this package in the dist directory
    twine upload dist/* --username $PYPI_USERNAME --password $PYPI_PASSWORD  # publish
else
    echo "No deployment - Only non-functional elements were modified in this change"
fi
