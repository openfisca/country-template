# Publish to conda

There are two ways to publish to conda:

- A fully automatic way applied in CI that publishes to an `openfisca` channel. See below for more information.
- A more complex way to publish on default [Conda-Forge](https://anaconda.org/conda-forge) channel. This repository is not published on Conda-Forge.

We use both for `openfisca-core` but only the `openfisca` channel for the `country-template`.

## Automatic upload

The CI automaticaly upload the PyPi package, see the `.github/workflow.yml`, step `publish-to-conda`.

## Manual actions made to make it works the first time

- Create an account on https://anaconda.org.
- Create a token on https://anaconda.org/openfisca/settings/access with _Allow write access to the API site_. Warning, it expire on 2023/01/13.
- Put the token in a CI env variable `ANACONDA_TOKEN`.

## Manual actions before CI exists

To create the package you can do the following in the project root folder:

- Edit `.conda/meta.yaml` and update it if needed with:
    - Version number
    - Hash SHA256
    - Package URL on PyPi

- Install `conda-build` to build the package and [anaconda-client](https://github.com/Anaconda-Platform/anaconda-client) to push the package to anaconda.org:
    - `conda install -c anaconda conda-build anaconda-client`

- Build & Upload package:
    - `conda build .conda`
    - `anaconda login`
    - `anaconda upload openfisca-country-template-<VERSION>-py_0.tar.bz2`
