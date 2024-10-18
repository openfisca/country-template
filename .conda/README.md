# Publish to conda

There are two ways to publish to conda:

- A fully automatic in CI that publish to an "openfisca" channel. See below for more information.
- A more complex for Conda-Forge.

We use both for openfisca-core but only _openfisca channel_ for _country-template_.

## Automatic upload

The CI automaticaly upload the PyPi package, see the `.github/workflow.yml`, step `publish-to-conda`.

## Test with Docker

Docker could be used to test the build and the installation of the package.

To test the build:

```sh
docker run --volume $PWD:/openfisca -i -t continuumio/anaconda3 /bin/bash
cd /openfisca
# Check meta.yaml
conda-build --check .conda
# Build
conda install conda-verify
conda config --add channels defaults
conda build -c openfisca -c conda-forge .conda
```

To test the installation of the published package:

```sh
docker run --volume $PWD:/openfisca -i -t continuumio/anaconda3 /bin/bash
cd /openfisca
conda install -c openfisca -c conda-forge openfisca-country-template
openfisca test --country-package openfisca-country-template tests
```

To do the publication of the package, normaly not needed as it is done by the CI! :

```sh
docker run --volume $PWD:/openfisca -i -t continuumio/anaconda3 /bin/bash
cd /openfisca
# Build
conda build -c openfisca -c conda-forge .conda
anaconda login
anaconda upload openfisca-country-template-<VERSION>-py_0.tar.bz2
```

## Manual actions made to make it works the first time

- Create an account on https://anaconda.org.
- Create a token on https://anaconda.org/openfisca/settings/access with _Allow write access to the API site_. Warning, it expire on 2023/01/13.
- Put the token in a CI env variable ANACONDA_TOKEN.
