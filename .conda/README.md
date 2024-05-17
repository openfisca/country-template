# Publish to conda

There are two ways to publish to conda:

- A fully automatic in CI that publish to an "openfisca" channel. See below for more information.
- A more complex for Conda-Forge.

We use both for openfisca-core but only _openfisca channel_ for _country-template_.

## Automatic upload

The CI automaticaly upload the PyPi package, see the `.github/workflow.yml`, step `publish-to-conda`.

## Manual actions made to make it works the first time

- Create an account on https://anaconda.org.
- Create a token on https://anaconda.org/openfisca/settings/access with _Allow write access to the API site_. Warning, it expire on 2023/01/13.
- Put the token in a CI env variable ANACONDA_TOKEN.

## Manual actions before CI exist

To create the package you can do the following in the project root folder:

- Edit `.conda/meta.yaml` and update it if needed:
    - Version number
    - Hash SHA256
    - Package URL on PyPi

- Install `conda-build` to build the package and [anaconda-client](https://github.com/Anaconda-Platform/anaconda-client) to push the package to anaconda.org:
    - `conda install -c anaconda conda-build anaconda-client`

- Build & Upload package:
    - `conda build .conda`
    - `anaconda login`
    - `anaconda upload openfisca-country-template-<VERSION>-py_0.tar.bz2`


## Test with Docker

Docker could be used to test the build and the installation of the package.

To test the build:

```sh
docker run --volume $PWD:/openfisca -i -t continuumio/anaconda3 /bin/bash
cd /openfisca
# Pour tester le meta.yaml
conda-build conda-recipe -c openfisca -c conda-forge .conda
# Pour lancer le build
conda build -c openfisca -c conda-forge .conda
```

To test the installation of the package:

```sh
docker run --volume $PWD:/openfisca -i -t continuumio/anaconda3 /bin/bash
cd /openfisca
conda install -c openfisca -c conda-forge openfisca-country-template
openfisca test --country-package openfisca-country-template tests
```