#! /usr/bin/env bash

# Usage: lint-files.sh <file_pattern> <linter_command>
#
# Example usage: 
#   lint-files.sh "*.py" "flake8"
#   lint-files.sh "tests/*.yaml" "yamllint"

file_pattern=$1
linter_command=$2

if [ -z "$file_pattern" ] || [ -z "$linter_command" ]
then
    echo "Usage: $0 <file_pattern> <linter_command>"
    exit 1
fi

last_tagged_commit=$(git describe --tags --abbrev=0 --first-parent 2>/dev/null) # Attempt to find the last tagged commit in the direct ancestry of the main branch avoiding tags introduced by merge commits from other branches

if [ -z "$last_tagged_commit" ]
then
    last_tagged_commit=$(git rev-list --max-parents=0 HEAD) # Fallback to finding the root commit if no tags are present
fi

if ! changed_files=$(git diff-index --name-only --diff-filter=ACMR --exit-code $last_tagged_commit -- "$file_pattern")
then
    echo "Linting the following files:"
    echo "$changed_files"
    $linter_command $changed_files
else
    echo "No changed files matching pattern '$file_pattern' to lint."
fi
