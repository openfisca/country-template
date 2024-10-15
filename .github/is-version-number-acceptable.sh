#! /usr/bin/env bash

if [[ ${GITHUB_REF#refs/heads/} == main ]]
then
    echo "No need for a version check on main."
    exit 0
fi

if ! $(dirname "$BASH_SOURCE")/has-functional-changes.sh
then
    echo "No need for a version update."
    exit 0
fi

# parsing with tomllib is complicated, see
# https://github.com/python-poetry/poetry/issues/273
python_version=$(grep '^version =' pyproject.toml | cut -d '"' -f 2)

# we do the same for conda
conda_version=$(grep '^  version: \d' .conda/recipe.yaml | cut -d ' ' -f 4)

if [[ ! $python_version || ! $conda_version ]]
then
    echo "Error getting current version"
    exit 1
fi

if [[ "$python_version" != "$conda_version" ]]
then
    echo "Python ($python_version) and Conda ($conda_version) versions do not match"
    exit 1
fi

if git rev-parse --verify --quiet "$python_version"
then
    echo "Version $python_version already exists in commit:"
    git --no-pager log -1 "$python_version"
    echo
    echo "Update the version number in pyproject.toml before merging this branch into main."
    echo "Look at the CONTRIBUTING.md file to learn how the version number should be updated."
    exit 2
fi

if ! $(dirname "$BASH_SOURCE")/has-functional-changes.sh | grep --quiet CHANGELOG.md
then
    echo "CHANGELOG.md has not been modified, while functional changes were made."
    echo "Explain what you changed before merging this branch into main."
    echo "Look at the CONTRIBUTING.md file to learn how to write the changelog."
    exit 2
fi
