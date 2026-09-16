test:
	uv run openfisca test --country-package openfisca_country_template openfisca_country_template/tests

serve-local:
	uv run openfisca serve --country-package openfisca_country_template
