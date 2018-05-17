#!/bin/sh

set -e

if ./detect-functional-changes.sh
then
    git tag `python setup.py --version`
    git push --tags  # update the repository version
    python setup.py bdist_wheel  # build this package in the dist directory
    twine upload dist/* --username $PYPI_USERNAME --password $PYPI_PASSWORD  # publish
    ssh -o StrictHostKeyChecking=no deploy-api@fr.openfisca.org  # Deploy the OpenFisca-France public API
else
    echo "No deployment - Only non-functional elements were modified in this change"
fi
