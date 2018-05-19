#! /usr/bin/env bash

VERSION_CHANGE_TRIGGERS="setup.py MANIFEST.in openfisca_country_template"

last_tagged_commit=`git describe --tags --abbrev=0 --first-parent`  # --first-parent ensures we don't follow tags not published in master through an unlikely intermediary merge commit

if git diff-index --shortstat $last_tagged_commit -- $VERSION_CHANGE_TRIGGERS ":(exclude)*.md"
then echo "No functional changes detected."
else exit 1
fi
