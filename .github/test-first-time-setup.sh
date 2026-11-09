#!/bin/bash

set -ev

#git worktree remove test-in-ci --force
ORIGIN=`pwd`

# Mock running script in CI
rm -fr ../openfisca-country-template-test-first-time-setup/test-in-ci
git worktree prune
git worktree add ../openfisca-country-template-test-first-time-setup/test-in-ci HEAD
cd ../openfisca-country-template-test-first-time-setup/test-in-ci

export JURISDICTION_NAME="No country in CI"
export REPOSITORY_URL="https://githost.example/no-organisation/openfisca-no-country-in-ci"
ls -al

CI=1 ./first-time-setup.sh

uv run make test
cd . && pwd


# Mock running script locally
cd $ORIGIN
rm -fr ../openfisca-country-template-test-first-time-setup/test-manual
git worktree prune
git worktree add ../openfisca-country-template-test-first-time-setup/test-manual HEAD
cd ../openfisca-country-template-test-first-time-setup/test-manual

export JURISDICTION_NAME="No country locally"
export REPOSITORY_URL="https://githost.example/no-organisation/openfisca-no-country-locally"

rm -fr .git
ls -al

./first-time-setup.sh

uv run make test
cd . && pwd
cd . && pwd | grep openfisca-no_country_locally$
cd .. && rm -fr openfisca-no_country_locally
