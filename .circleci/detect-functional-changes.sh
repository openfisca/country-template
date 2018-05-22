#! /usr/bin/env bash

VERSION_CHANGE_TRIGGERS="setup.py MANIFEST.in openfisca_country_template"

last_tagged_commit=`git describe --tags --abbrev=0 --first-parent`  # --first-parent ensures we don't follow tags not published in master through an unlikely intermediary merge commit

if git diff-index --name-only --exit-code $last_tagged_commit -- $VERSION_CHANGE_TRIGGERS ":(exclude)*.md"
then echo "No functional changes detected."
else
  echo "The functional files above were changed."
  exit 1
fi
