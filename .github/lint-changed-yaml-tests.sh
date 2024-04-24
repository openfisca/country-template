#! /usr/bin/env bash

if ! changed_files=$(git diff-index --name-only --diff-filter=ACMR --exit-code master -- "tests/*.yaml")
then
  echo "Linting the following changed YAML tests:"
  echo $changed_files
  yamllint $changed_files
else echo "No changed YAML tests to lint"
fi
