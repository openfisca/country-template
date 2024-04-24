#! /usr/bin/env bash

if ! changed_files=$(git diff-index --name-only --diff-filter=ACMR --exit-code main -- "*.py")
then
  echo "Linting the following Python files:"
  echo $changed_files
  flake8 $changed_files
else echo "No changed Python files to lint"
fi
