#! /usr/bin/env bash

VERSION_CHANGE_TRIGGERS="setup.py MANIFEST.in openfisca_country_template"
CURRENT_BRANCH=`git symbolic-ref --short HEAD`

if [[ "$CURRENT_BRANCH" == "python3" ]]
then LAST_MASTER_VERSION="HEAD^"
else LAST_MASTER_VERSION="origin/python3"
fi

if git diff-index --quiet $LAST_MASTER_VERSION -- $VERSION_CHANGE_TRIGGERS ":(exclude)*.md"
then echo "No functional changes detected."
else exit 1
fi
