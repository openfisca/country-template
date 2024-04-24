#! /usr/bin/env bash

if ! changes=$(git diff-index --name-only --diff-filter=ACMR --exit-code main -- "tests/*.yaml")
then
  echo "Linting the following changed YAML tests:"
  echo $changes
  yamllint $changes
else echo "No changed YAML tests to lint"
fi
