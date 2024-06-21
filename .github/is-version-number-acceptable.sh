#! /usr/bin/env bash

current_version=$(grep '^version =' pyproject.toml | cut -d '"' -f 2)  # parsing with tomllib is complicated, see https://github.com/python-poetry/poetry/issues/273

if [[ ! $current_version ]]
then
    echo "Error getting current version"
    exit 1
fi

if git rev-parse --verify --quiet $current_version
then
    echo "Version $current_version already exists in commit:"
    git --no-pager log -1 $current_version
    echo
    echo "Update the version number in pyproject.toml before merging this branch into main."
    echo "Look at the CONTRIBUTING.md file to learn how the version number should be updated."
    exit 2
fi
