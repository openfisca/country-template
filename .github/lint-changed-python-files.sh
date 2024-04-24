#! /usr/bin/env bash

if ! changes=$(git diff-index --name-only --diff-filter=ACMR --exit-code main -- "*.py")
then
  echo "Linting the following Python files:"
  echo $changes
  flake8 $changes
else echo "No changed Python files to lint"
fi
