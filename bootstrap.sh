#!/bin/bash

set -e
GREEN='\033[0;32m'
PURPLE='\033[1;35m'
YELLOW='\033[0;33m'
BLUE='\033[1;34m'

if [[ -d .git ]]
then
	echo 'It seems you cloned this repository, or already initialised it.'
	echo 'Refusing to go further as you might lose work.'
	echo "If you are certain this is a new repository, run 'cd $(dirname $0) && rm -rf .git' to erase the history."
	exit 2
fi

if ! test $JURISDICTION_NAME
then
	while true; do
		echo -e "${GREEN}The name of the jurisdiction (country?) you will model the rules of: \033[0m (i.e. New Zealand)"
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
		echo -e "${GREEN}Your git repository URL: \033[0m (i.e. https://githost.example/organisation/openfisca-jurisdiction)"
		read REPOSITORY_URL
		if [[ "$REPOSITORY_URL"  != "" ]]
		then
			REPOSITORY_FOLDER=$(echo ${REPOSITORY_URL##*/})
			break
		fi
	done
fi

cd $(dirname $0)  # support being called from anywhere on the file system

echo -e "${PURPLE}Jurisdiction title set to: \033[0m${BLUE}$JURISDICTION_NAME\033[0m"
# Removes hyphens for python environment
echo -e "${PURPLE}Jurisdiction python label: \033[0m${BLUE}$CODE_JURISDICTION_LABEL\033[0m"
echo -e "${PURPLE}Git Repository URL       : \033[0m${BLUE}$REPOSITORY_URL\033[0m"
read -p "Would you like to continue (y/n): " choice
case "$choice" in 
  y|Y ) echo -e "${YELLOW}Yes selected, continuing…\033[0m";;
  n|N ) 
		echo "No selected, exiting."
		exit 1
		;;
  * ) echo "Invalid response, expected y or n, exiting."
		exit 1
		;;
esac

parent_folder=${PWD##*/} 

last_bootstrapping_line_number=$(grep --line-number '^## Writing the Legislation' README.md | cut -d ':' -f 1)
last_changelog_number=$(grep --line-number '^# Example Entry' CHANGELOG.md | cut -d ':' -f 1)

first_commit_message='Initial import from OpenFisca country-template'
second_commit_message='Customise country-template through script'

echo -e ""
cd ..
mv $parent_folder openfisca-$NO_SPACES_JURISDICTION_LABEL
cd openfisca-$NO_SPACES_JURISDICTION_LABEL

echo -e "${PURPLE}*  ${PURPLE}Initialise git repository\033[0m"
git init --initial-branch=main > /dev/null 2>&1
git add .

git commit --no-gpg-sign --message "$first_commit_message" --author='OpenFisca Bot <bot@openfisca.org>' --quiet
echo -e "${PURPLE}*  ${PURPLE}Initial git commit made to 'main' branch: '\033[0m${BLUE}$first_commit_message\033[0m${PURPLE}'\033[0m"

all_module_files=`find openfisca_country_template -type f ! -name "*.DS_Store"`
echo -e "${PURPLE}*  ${PURPLE}Replace default country_template references\033[0m"
# Use intermediate backup files (`-i`) with a weird syntax due to lack of portable 'no backup' option. See https://stackoverflow.com/q/5694228/594053.
sed -i.template "s|openfisca-country_template|openfisca-$NO_SPACES_JURISDICTION_LABEL|g" README.md Makefile pyproject.toml CONTRIBUTING.md
sed -i.template "s|country_template|$CODE_JURISDICTION_LABEL|g" README.md pyproject.toml .flake8 .github/workflows/workflow.yml Makefile MANIFEST.in $all_module_files
sed -i.template "s|Country-Template|$JURISDICTION_NAME|g" README.md pyproject.toml .github/workflows/workflow.yml .github/PULL_REQUEST_TEMPLATE.md CONTRIBUTING.md

echo -e "${PURPLE}*  ${PURPLE}Remove bootstrap instructions\033[0m"
sed -i.template -e "3,${last_bootstrapping_line_number}d" README.md  # remove instructions lines

echo -e "${PURPLE}*  ${PURPLE}Prepare \033[0m${BLUE}README.MD\033[0m${PURPLE} and \033[0m${BLUE}CONTRIBUTING.md\033[0m"
sed -i.template "s|https://example.com/repository|$REPOSITORY_URL|g" README.md CONTRIBUTING.md

echo -e "${PURPLE}*  ${PURPLE}Prepare \033[0m${BLUE}CHANGELOG.md\033[0m"
sed -i.template -e "1,${last_changelog_number}d" CHANGELOG.md  # remove country-template CHANGELOG leaving example

echo -e "${PURPLE}*  ${PURPLE}Prepare \033[0m${BLUE}pyproject.toml\033[0m"
sed -i.template "s|https://github.com/openfisca/country-template|$REPOSITORY_URL|g" pyproject.toml
sed -i.template "s|:: 5 - Production/Stable|:: 1 - Planning|g" pyproject.toml
sed -i.template "s|repository_folder|$REPOSITORY_FOLDER|g" README.md
find . -name "*.template" -type f -delete

echo -e "${PURPLE}*  ${PURPLE}Rename parent directory to: \033[0m${BLUE}openfisca_$CODE_JURISDICTION_LABEL\033[0m"
git mv openfisca_country_template openfisca_$CODE_JURISDICTION_LABEL

echo -e "${PURPLE}*  ${PURPLE}Remove single use \033[0m${BLUE}bootstrap.sh\033[0m${PURPLE} script\033[0m"
git rm bootstrap.sh > /dev/null 2>&1
git add .
git commit --no-gpg-sign --message "$second_commit_message" --author='OpenFisca Bot <bot@openfisca.org>' --quiet

echo -e "${PURPLE}*  ${PURPLE}Second git commit made to 'main' branch: '\033[0m${BLUE}$second_commit_message\033[0m${PURPLE}'\033[0m"
echo -e ""
cd ../openfisca-$NO_SPACES_JURISDICTION_LABEL

echo -e "${YELLOW}* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * \033[0m"
echo -e "${YELLOW}*\033[0m  Bootstrap complete, don't forget to push to remote repository\033[0m"
echo -e "${YELLOW}*\033[0m "
echo -e "${YELLOW}*\033[0m  $ ${BLUE}git remote add origin $REPOSITORY_URL.git\033[0m"
echo -e "${YELLOW}*\033[0m  $ ${BLUE}git push origin main\033[0m"
echo -e "${YELLOW}*\033[0m "
echo -e "${YELLOW}*\033[0m  Then refer to the project's \033[0m${BLUE}README.md\033[0m"
echo -e "${YELLOW}*\033[0m"
echo -e "${YELLOW}* * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * * \033[0m"

exec bash
