all: test

uninstall:
	pip freeze | grep -v "^-e" | sed "s/@.*//" | xargs pip uninstall -y

clean:
	rm -rf build dist
	find . -name '*.pyc' -exec rm \{\} \;

deps:
	pip install --upgrade pip build twine

install: deps
	@# Install OpenFisca-Extension-Template for development.
	@# `make install` installs the editable version of openfisca-country_template.
	@# This allows contributors to test as they code.
	pip install --editable .[dev] --upgrade

build: clean deps
	@# Install OpenFisca-Extension-Template for deployment and publishing.
	@# `make build` allows us to be be sure tests are run against the packaged version
	@# of OpenFisca-Extension-Template, the same we put in the hands of users and reusers.
	python -m build
	pip uninstall --yes openfisca-country-template
	find dist -name "*.whl" -exec pip install --force-reinstall {}[dev] \;

check-syntax-errors:
	python -m compileall -q .

format-style:
	@# Do not analyse .gitignored files.
	@# `make` needs `$$` to output `$`. Ref: http://stackoverflow.com/questions/2382764.
	ruff format `git ls-files | grep "\.py$$"`
	isort `git ls-files | grep "\.py$$"`
	black `git ls-files | grep "\.py$$"`

check-style:
	@# Do not analyse .gitignored files.
	@# `make` needs `$$` to output `$`. Ref: http://stackoverflow.com/questions/2382764.
	ruff check `git ls-files | grep "\.py$$"`
	isort --check `git ls-files | grep "\.py$$"`
	black --check `git ls-files | grep "\.py$$"`

check-yaml:
	@# Do not analyse .gitignored files.
	@# `make` needs `$$` to output `$`. Ref: http://stackoverflow.com/questions/2382764.
	yamllint `git ls-files | grep "\.yaml$$"`

test: clean check-syntax-errors check-style
	openfisca test --country-package openfisca_country_template openfisca_country_template/tests

serve-local: build
	openfisca serve --country-package openfisca_country_template
