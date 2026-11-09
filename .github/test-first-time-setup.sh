#!/bin/bash

set -ev

ORIGIN=$(pwd)

function check_folder() {
    uv run make test
    if grep test-first-time-setup.sh .github/workflows/ci.yaml --line-number
    then
        echo "Mention of test-first-time-setup.sh in .github/workflows/ci.yaml should have been removed"
        exit 1
    fi
    cd . && pwd
}

# Mock running script in CI
git worktree prune
git worktree add ../openfisca-country-template-test-first-time-setup/test-in-ci HEAD
cd ../openfisca-country-template-test-first-time-setup/test-in-ci

export JURISDICTION_NAME="No country in CI"
export REPOSITORY_URL="https://githost.example/no-organisation/openfisca-no-country-in-ci"
ls -al

CI=1 ./first-time-setup.sh

check_folder
cd .. && rm -fr test-in-ci


# Mock running script locally
cd $ORIGIN
git worktree prune
git worktree add ../openfisca-country-template-test-first-time-setup/test-manual HEAD
cd ../openfisca-country-template-test-first-time-setup/test-manual

export JURISDICTION_NAME="No country locally"
export REPOSITORY_URL="https://githost.example/no-organisation/openfisca-no-country-locally"

rm -fr .git
ls -al

unset CI && ./first-time-setup.sh

check_folder
cd . && pwd | grep openfisca-no_country_locally$
cd .. && rm -fr openfisca-no_country_locally
