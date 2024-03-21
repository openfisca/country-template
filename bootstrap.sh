#!/bin/bash

set -e
GREEN='\033[0;32m'
PURPLE='\033[1;35m'
YELLOW='\033[0;33m'
BLUE='\033[1;34m'

if ! test $JURISDICTION_NAME
then
	while true; do
		echo -e "${GREEN}Your jurisdiction (country?) name: \033[0m (i.e. New Zealand)"
		read JURISDICTION_NAME
		if [[ "$JURISDICTION_NAME"  != "" ]]
		then
			lowercase_jurisdiction_name=$(echo $JURISDICTION_NAME | tr '[:upper:]' '[:lower:]')
			# Allows for hyphens to be used in jurisdiction names
			NO_SPACES_JURISDICTION_LABEL=$(echo $lowercase_jurisdiction_name | sed -r 's/[ ]+/_/g')
			# Removes hyphens for use in python
			CODE_JURISDICTION_LABEL=$(echo $NO_SPACES_JURISDICTION_LABEL | sed -r 's/[-]+/_/g')
			break
		fi
	done
fi

if ! test $REPOSITORY_URL
then
	while true; do
		echo -e "${GREEN}Your git repository URL: \033[0m (i.e. https://git***.com/organisation/openfisca-jurisdiction)"
		read REPOSITORY_URL
		if [[ "$REPOSITORY_URL"  != "" ]]
		then
			REPOSITORY_FOLDER=$(echo ${REPOSITORY_URL##*/})
			break
		fi
	done
fi

cd $(dirname $0)  # support being called from anywhere on the file system

if [[ -d .git ]]
then
	echo 'It seems you cloned this repository, or already initialised it.'
	echo 'Refusing to go further as you might lose work.'
	echo "If you are certain this is a new repository, run 'cd $(dirname $0) && rm -rf .git' to erase the history."
	exit 2
fi

echo -e "Jurisdiction title set to: ${PURPLE}$JURISDICTION_NAME\033[0m"
# Removes hyphens for python environment
echo -e "Jurisdiction python label: ${PURPLE}$CODE_JURISDICTION_LABEL\033[0m"
echo -e "Git Repository URL       : ${PURPLE}$REPOSITORY_URL\033[0m"
read -p "Would you like to continue (y/n): " choice
case "$choice" in 
  y|Y ) echo "yes";;
  n|N ) 
		echo "no"
		exit 1
		;;
  * ) echo "invalid";;
esac

parent_folder=${PWD##*/} 

last_bootstrapping_line_number=$(grep --line-number '^## Writing the Legislation' README.md | cut -d ':' -f 1)
last_changelog_number=$(grep --line-number '^# Example Entry' CHANGELOG.md | cut -d ':' -f 1)

first_commit_message='Initial import from OpenFisca country-template'
second_commit_message='Customise country-template through script'

cd ..
pwd
mv $parent_folder openfisca-$NO_SPACES_JURISDICTION_LABEL
cd openfisca-$NO_SPACES_JURISDICTION_LABEL

git init
git add .
git symbolic-ref HEAD refs/heads/main
git commit --no-gpg-sign --message "$first_commit_message" --author='OpenFisca Bot <bot@openfisca.org>'
echo -e "${YELLOW}--\033[0m"
echo -e "${PURPLE}Set default branch to 'main'.\033[0m"
echo -e "${PURPLE}Initial git commit made to 'main' branch: \033[0m${BLUE}$first_commit_message\033[0m"
echo -e "${YELLOW}--\033[0m"

all_module_files=`find openfisca_country_template -type f ! -name "*.DS_Store"`

set -x


# Use intermediate backup files (`-i`) with a weird syntax due to lack of portable 'no backup' option. See https://stackoverflow.com/q/5694228/594053.
sed -i.template "s|openfisca-country_template|openfisca-$NO_SPACES_JURISDICTION_LABEL|g" README.md Makefile pyproject.toml CONTRIBUTING.md
sed -i.template "s|country_template|$CODE_JURISDICTION_LABEL|g" README.md pyproject.toml .flake8 .github/workflows/workflow.yml Makefile MANIFEST.in $all_module_files
sed -i.template "s|Country-Template|$JURISDICTION_NAME|g" README.md pyproject.toml .github/workflows/workflow.yml .github/PULL_REQUEST_TEMPLATE.md CONTRIBUTING.md
sed -i.template -e "3,${last_bootstrapping_line_number}d" README.md  # remove instructions lines
sed -i.template "s|https://example.com/repository|$REPOSITORY_URL|g" README.md CONTRIBUTING.md
sed -i.template -e "1,${last_changelog_number}d" CHANGELOG.md  # remove country-template CHANGELOG leaving example
sed -i.template "s|https://github.com/openfisca/country-template|$REPOSITORY_URL|g" pyproject.toml
sed -i.template "s|repository_folder|$REPOSITORY_FOLDER|g" README.md
find . -name "*.template" -type f -delete

set +x

git mv openfisca_country_template openfisca_$CODE_JURISDICTION_LABEL

git rm bootstrap.sh
git add .
git commit --no-gpg-sign --message "$second_commit_message" --author='OpenFisca Bot <bot@openfisca.org>'
echo -e "${YELLOW}--\033[0m"
echo -e "${PURPLE}Second git commit made: \033[0m${BLUE}$second_commit_message\033[0m"
git remote add origin $REPOSITORY_URL.git
echo -e "${PURPLE}Git remote origin added: \033[0m${BLUE}$REPOSITORY_URL.git\033[0m"
echo -e "${YELLOW}--\033[0m"

echo -e "${YELLOW}***********************************************************************\033[0m"
echo -e "${YELLOW}*\033[0m  Navigate to your project folder via: "
echo -e "${YELLOW}*\033[0m  $ ${BLUE}cd ../openfisca-$NO_SPACES_JURISDICTION_LABEL\033[0m"
echo -e "${YELLOW}*\033[0m"
echo -e "${YELLOW}*\033[0m  Setup, activate a virtual environment:"
echo -e "${YELLOW}*\033[0m  $ ${BLUE}python3.9 -m venv .venv\033[0m"
echo -e "${YELLOW}*\033[0m  $ ${BLUE}source .venv/bin/activate\033[0m"
echo -e "${YELLOW}*\033[0m"
echo -e "${YELLOW}*\033[0m  Ensure pip, build & twine are updated, then install project:"
echo -e "${YELLOW}*\033[0m  $ ${BLUE}pip install --upgrade pip build twine\033[0m"
echo -e "${YELLOW}*\033[0m  $ ${BLUE}pip install --editable .[dev] --upgrade\033[0m"
echo -e "${YELLOW}*\033[0m  (note: Makefile equivalent command: ${BLUE}make install\033[0m)"
echo -e "${YELLOW}*\033[0m"
echo -e "${YELLOW}*\033[0m  If Makefile is available, the following will run all tests:"
echo -e "${YELLOW}*\033[0m  $ ${BLUE}make all\033[0m"
echo -e "${YELLOW}*\033[0m  (refer to ./Makefile for other examples)"
echo -e "${YELLOW}*\033[0m"
echo -e "${YELLOW}*\033[0m  Finally, push changes to your git host:"
echo -e "${YELLOW}*\033[0m  $ ${BLUE}git push origin main\033[0m"
echo -e "${YELLOW}*\033[0m"
echo -e "${YELLOW}***********************************************************************\033[0m"
