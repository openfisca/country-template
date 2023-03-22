"""This file contains your country package's metadata and dependencies."""

from pathlib import Path

from setuptools import find_packages, setup

# Read the contents of our README file for PyPi
this_directory = Path(__file__).parent
long_description = (this_directory / "README.md").read_text()  # pylint: disable=W1514

setup(
    name = "OpenFisca-Country-Template",
    version = "5.0.0",
    author = "OpenFisca Team",
    author_email = "contact@openfisca.org",
    classifiers = [
        "Development Status :: 5 - Production/Stable",
        "License :: OSI Approved :: GNU Affero General Public License v3",
        "Operating System :: POSIX",
        "Programming Language :: Python",
        "Programming Language :: Python :: 3.9",
        "Programming Language :: Python :: 3.10",
        "Programming Language :: Python :: 3.11",
        "Topic :: Scientific/Engineering :: Information Analysis",
        ],
    description = "OpenFisca tax and benefit system for Country-Template",
    long_description=long_description,
    long_description_content_type="text/markdown",
    keywords = "benefit microsimulation social tax",
    license = "http://www.fsf.org/licensing/licenses/agpl-3.0.html",
    license_files = ("LICENSE",),
    url = "https://github.com/openfisca/country-template",
    include_package_data = True,  # Will read MANIFEST.in
    data_files = [
        (
            "share/openfisca/openfisca-country-template",
            ["CHANGELOG.md", "README.md"],
            ),
        ],
    install_requires = [
        # "openfisca-core[web-api] >= 38.0.0, < 39.0.0",
        "OpenFisca-Core @ git+https://github.com/openfisca/openfisca-core.git@version_leap",
        ],
    extras_require = {
        "dev": [
            "autopep8",
            "flake8",
            "flake8-bugbear",
            "flake8-builtins",
            "flake8-coding",
            "flake8-commas",
            "flake8-comprehensions",
            "flake8-docstrings",
            "flake8-import-order",
            "flake8-print",
            "flake8-quotes",
            "flake8-simplify",
            "flake8-use-fstring",
            "importlib-metadata",
            "pycodestyle",
            "pylint",
            ],
        },
    packages = find_packages(),
    )
