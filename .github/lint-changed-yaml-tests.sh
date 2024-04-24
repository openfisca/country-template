#! /usr/bin/env bash

last_tagged_commit=`git describe --tags --abbrev=0 --first-parent`  # --first-parent ensures we don't follow tags not published in main through an unlikely intermediary merge commit

if ! changed_files=$(git diff-index --name-only --diff-filter=ACMR --exit-code $last_tagged_commit -- "tests/*.yaml")
then
  echo "Linting the following changed YAML tests:"
  echo $changed_files
  yamllint $changed_files
else echo "No changed YAML tests to lint"
fi
