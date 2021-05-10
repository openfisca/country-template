all: test
test: clean check-syntax-errors check-safety check-style run-tests

uninstall:
	pip freeze | grep -v "^-e" | xargs pip uninstall -y

deps:
	pip install --upgrade pip twine wheel

install: deps
	@# Install OpenFisca-Extension-Template for development.
	@# `make install` installs the editable version of OpenFisca-France.
	@# This allows contributors to test as they code.
	pip install -e '.[dev]' --upgrade --use-deprecated=legacy-resolver

build: clean deps
	@# Install OpenFisca-Extension-Template for deployment and publishing.
	@# `make build` allows us to be be sure tests are run against the packaged version
	@# of OpenFisca-Extension-Template, the same we put in the hands of users and reusers.
	python setup.py bdist_wheel
	find dist -name "*.whl" -exec pip install --force-reinstall {}[dev] \;

format-style:
	@# Do not analyse .gitignored files.
	@# `make` needs `$$` to output `$`. Ref: http://stackoverflow.com/questions/2382764.
	pyupgrade --py37-plus `git ls-files | grep "\.py$$"`
	autopep8 `git ls-files | grep "\.py$$"`

clean:
	rm -rf build dist
	find . -name '*.pyc' -exec rm \{\} \;

check-syntax-errors:
	python -m compileall -q .

check-safety:
	pip check

check-style:
	@# Do not analyse .gitignored files.
	@# `make` needs `$$` to output `$`. Ref: http://stackoverflow.com/questions/2382764.
	pylint `git ls-files | grep "\.py$$"`
	flake8 `git ls-files | grep "\.py$$"`

run-tests:
	openfisca test --country-package openfisca_country_template openfisca_country_template/tests

serve-local: build
	openfisca serve --country-package openfisca_country_template
