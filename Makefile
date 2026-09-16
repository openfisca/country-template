all: test

uninstall:
	uv pip uninstall openfisca-country_template || true

clean:
	rm -rf build dist
	find . -name '*.pyc' -exec rm \{\} \;
	find . -type d -name '__pycache__' -exec rm -r {} +

build: clean
	@# Install openfisca-country_template for deployment and publishing.
	@# `make build` allows us to be sure tests are run against the packaged version
	@# of openfisca-country_template, the same we put in the hands of users and reusers.
	uv sync --frozen
	uv build
	uv pip uninstall --yes openfisca-country_template 2>/dev/null || true
	find dist -name "*.whl" -exec uv pip install --force-reinstall {}[dev] \;

format:
	@# Do not analyse .gitignored files. Ruff format + ruff check --fix (imports, etc.).
	@# `make` needs `$$` to output `$`. Ref: http://stackoverflow.com/questions/2382764.
	uv run --frozen ruff format `git ls-files | grep "\.py$$"`
	uv run --frozen ruff check --fix `git ls-files | grep "\.py$$"`

check-syntax-errors:
	@# Check Python syntax errors.
	@# `make` needs `$$` to output `$`. Ref: http://stackoverflow.com/questions/2382764.
	@uv run --frozen python -m py_compile `git ls-files | grep "\.py$$"` 2>&1 || (echo "Syntax errors found" && exit 1)

check-style: lint

lint:
	@# Do not analyse .gitignored files.
	@# `make` needs `$$` to output `$`. Ref: http://stackoverflow.com/questions/2382764.
	uv run --frozen ruff check --exit-zero `git ls-files | grep "\.py$$"`
	uv run --frozen ruff format --check `git ls-files | grep "\.py$$"`
	uv run --frozen yamllint `git ls-files | grep "\.yaml$$"`

test: clean
	@# Remove stale or duplicate .dist-info so only one version's metadata is visible (avoids AttributeError on get("Name").lower()).
	@rm -rf .venv/lib/python*/site-packages/openfisca_country_template-*.dist-info 2>/dev/null || true
	@# Path must be openfisca_country_template/tests only (not the whole package), so parameter YAMLs are not collected as tests.
	uv run --frozen openfisca test --country-package openfisca_country_template openfisca_country_template/tests

# Run the same checks as the CI (validate workflow), without the version/changelog check.
ci: check-syntax-errors check-style
	@bash .github/lint-files.sh "*.py" "uv run ruff check --exit-zero"
	@bash .github/lint-files.sh "openfisca_country_template/tests/*.yaml" "uv run yamllint"
	$(MAKE) test

serve-local: build
	uv run --frozen openfisca serve --country-package openfisca_country_template
