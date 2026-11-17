#! /usr/bin/env bash

IGNORE_DIFF_ON="README.md CONTRIBUTING.md Makefile .gitignore .github/*"

tag_count=`git tag | wc -l`
if [[ $tag_count -eq 0 ]]
then
  # A fresh repository has no tag yet (the first-time setup creates 0.0.1).
  # Compare against the initial commit instead of assuming functional changes.
  last_tagged_commit=`git rev-list --max-parents=0 HEAD | tail -1`
  echo "No tags found. Comparing against the initial commit $last_tagged_commit."
else
  last_tagged_commit=`git describe --tags --abbrev=0 --first-parent`  # --first-parent ensures we don't follow tags not published in main through an unlikely intermediary merge commit
fi

if git diff-index --name-only --exit-code $last_tagged_commit -- . `echo " $IGNORE_DIFF_ON" | sed 's/ / :(exclude)/g'`  # Check if any file that has not be listed in IGNORE_DIFF_ON has changed since the last tag was published.
then
  echo "No functional changes detected."
  exit 1
else echo "The functional files above were changed."
fi
