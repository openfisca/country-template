#! /usr/bin/env bash

last_tagged_commit=$(git describe --tags --abbrev=0 --first-parent 2>/dev/null) # Attempt to find the last tagged commit in the direct ancestry of the main branch avoiding tags introduced by merge commits from other branches

if [ -z "$last_tagged_commit" ]
then
    last_tagged_commit=$(git rev-list --max-parents=0 HEAD) # Fallback to finding the root commit if no tags are present
fi

if ! changed_files=$(git diff-index --name-only --diff-filter=ACMR --exit-code $last_tagged_commit -- "*.py")
then
  echo "Linting the following Python files:"
  echo $changed_files
  flake8 $changed_files
else echo "No changed Python files to lint"
fi
