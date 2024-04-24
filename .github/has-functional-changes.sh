#! /usr/bin/env bash

IGNORE_DIFF_ON="README.md CONTRIBUTING.md Makefile .gitignore .github/*"

if git diff-index --name-only --exit-code master -- . `echo " $IGNORE_DIFF_ON" | sed 's/ / :(exclude)/g'`  # Check if any file that has not be listed in IGNORE_DIFF_ON has changed since the last tag was published.
then
  echo "No functional changes detected."
  exit 1
else echo "The functional files above were changed."
fi
