#!/bin/sh

VERSION_CHANGE_TRIGGERS="setup.py MANIFEST.in openfisca_country_template"

if git diff-index --quiet origin/master -- $VERSION_CHANGE_TRIGGERS ":(exclude)*.md"
then echo "No functional changes detected."
else exit 1
fi
