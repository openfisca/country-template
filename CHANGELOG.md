# Changelog

## Unreleased [no-release]

_Modifications made in this changeset do not add, remove or alter any behavior, dependency, API or functionality of the software. They only change non-functional parts of the repository, such as the README file or CI workflows._

## 7.1.3 - 2024-05-21

_Full changeset and discussions: [#152](https://github.com/openfisca/country-template/pull/152)._

### Changed

- Update classifiers in pyproject.toml to include all supported versions of Python

## 7.1.2 - 2024-05-10

_Full changeset and discussions: [#147](https://github.com/openfisca/country-template/pull/147)._

### Changed

- Skip `deploy` workflow when PyPI token is not defined in GitHub secrets
- Ensure lint scripts work properly without reachable tags
- Rename the GitHub secret `PYPI_TOKEN_OPENFISCA_BOT` used in `deploy` workflow to `PYPI_TOKEN`
- Update deprecated syntax in GitHub Actions workflow

## 7.1.1 - 2024-05-07

_Full changeset and discussions: [#146](https://github.com/openfisca/country-template/pull/146)._

### Changed

- Update minimal Core dependency to require a version that can parse `pyproject.toml`
- Use version specifiers compatible with Conda packaging

## 7.1.0 - 2024-05-03

_Full changeset and discussions: [#143](https://github.com/openfisca/country-template/pull/143)._

### Changed

- Automate template setup process via CI for GitHub users
- Improve accessibility by adopting less technical terminology
- Decompose GitHub Actions monolithic workflow into specialized workflows
- Enhance accuracy of workflow triggers
- Update CI dependencies

## 7.0.0 - 2024-05-02

_Full changeset and discussions: [#139](https://github.com/openfisca/country-template/pull/139)._

### Changed

- Make template setup process interactive
- Replace `master` branch with `main`
- Replace `setup.py` and `setup.cfg` with `pyproject.toml`
- Remove references to `OpenFisca France`
- Alter `README.md` to allow for improved text replacements
- Lint files
- Add an example entry to the changelog
- Relax Python version constraint

## 6.0.3 - 2023-09-15

_Full changeset and discussions: [#136](https://github.com/openfisca/country-template/pull/136)._

### Changed

- Update openfisca-core version >= 41.0

## 6.0.2 - 2023-07-03

_Full changeset and discussions: [#132](https://github.com/openfisca/country-template/pull/132)._

### Changed

- Allow country-template to pass `check-style` makefile command

## 6.0.1 - 2023-06-14

_Full changeset and discussions: [#134](https://github.com/openfisca/country-template/pull/134)._

### Changed

- Avoid `sed: RE error: illegal byte sequence` error when template contains `.DS_Store` files after GUI navigation in macOS

## 6.0.0 - 2023-06-08

_Full changeset and discussions: [#129](https://github.com/openfisca/country-template/pull/129)._

### Changed

- **Breaking:** drop support for Python versions < 3.9
- Upgrade every dependency & use their latest versions to support Python 3.9 and 3.10

## 5.0.0 - 2022-12-12

_Full changeset and discussions: [#128](https://github.com/openfisca/country-template/pull/128)._

### Changed

- **Breaking:** upgrade Web API specification to OpenAPI v3; users relying on OpenAPI v2 can use Swagger Converter to migrate

## 4.0.0 - 2022-12-07

_Full changeset and discussions: [#127](https://github.com/openfisca/country-template/pull/127)._

### Changed

- **Breaking:** remove class `Bracket`; functionality is now provided by `ParameterScaleBracket`

## 3.13.3 - 2022-12-07

_Full changeset and discussions: [#122](https://github.com/openfisca/country-template/pull/122)._

### Fixed

- Add pull request as GitHub Actions workflow trigger

## 3.13.2 - 2022-02-04

_Full changeset and discussions: [#123](https://github.com/openfisca/country-template/pull/123)._

### Fixed

- Add tar.gz to PyPi to be used by conda to build conda package

## 3.13.1 - 2021-10-21

_Full changeset and discussions: [#120](https://github.com/openfisca/country-template/pull/120)._

### Changed

- Delete macOS related comment in bootstrap script

## 3.13.0 - 2021-10-21

_Full changeset and discussions: [#115](https://github.com/openfisca/country-template/pull/115)._

### Changed

- Switch continuous integration pipeline from CircleCI to GitHub Actions

## 3.12.10 - 2021-10-21

_Full changeset and discussions: [#119](https://github.com/openfisca/country-template/pull/119)._

### Changed

- Update README
- Add encoding to open JSON files

## 3.12.9 - 2021-08-18

_Full changeset and discussions: [#113](https://github.com/openfisca/country-template/pull/113)._

### Added

- Add a Web API smoke test to the CI

## 3.12.8 - 2021-05-10

_Full changeset and discussions: [#105](https://github.com/openfisca/country-template/pull/105)._

### Changed

- Upgrade `flake8-print`

## 3.12.7 - 2021-05-10

_Full changeset and discussions: [#104](https://github.com/openfisca/country-template/pull/104)._

### Changed

- Upgrade `flake8-bugbear`

## 3.12.6 - 2021-05-10

_Full changeset and discussions: [#102](https://github.com/openfisca/country-template/pull/102)._

### Fixed

- Fix `parenting_allowance` formula syntax
- Use vectorial computing to return a `parenting_allowance` amount per household

## 3.12.5 - 2021-03-26

_Full changeset and discussions: [#107](https://github.com/openfisca/country-template/pull/107)._

### Changed

- Force the installation of the new build each time `make build` is run
- CircleCI tests against the packaged version of this library

## 3.12.4 - 2021-03-09

_Full changeset and discussions: [#103](https://github.com/openfisca/country-template/pull/103)._

### Fixed

- Correct changelog history: `3.13.0` was supposed to be `3.12.3`, `3.12.0` and `3.12.1` are unpublished

## 3.12.3 - 2021-03-07

_Full changeset and discussions: [#97](https://github.com/openfisca/country-template/pull/97)._

### Changed

- Make style checks stricter and clearer to help country package developers get started

## 3.12.2 - 2021-02-03

_Full changeset and discussions: [#99](https://github.com/openfisca/country-template/pull/99)._

### Added

- Add a new variable called `parenting_allowance` to show how group entities and single entities can be used together

## 3.12.1 - 2021-02-03

_Version `3.12.1` was published by mistake. Please use version `3.12.2` or more recent._

## 3.12.0 - 2021-02-03

_Version `3.12.0` was published by mistake. Please use version `3.12.2` or more recent._

## 3.11.0 - 2020-12-14

_Full changeset and discussions: [#90](https://github.com/openfisca/country-template/pull/90)._

### Added

- Declare package compatible with OpenFisca-Core v35 that updates `numpy` dependency

## 3.10.0 - 2020-10-20

_Full changeset and discussions: [#98](https://github.com/openfisca/country-template/pull/98)._

### Added

- Add a new reform example creating a variable

## 3.9.13 - 2020-10-17

_Full changeset and discussions: [#96](https://github.com/openfisca/country-template/pull/96)._

### Removed

- Remove wildcard imports as they are considered an anti-pattern

## 3.9.12 - 2020-10-17

_Full changeset and discussions: [#93](https://github.com/openfisca/country-template/pull/93)._

### Changed

- Upgrade `autopep8`, `flake8` & `pycodestyle`

## 3.9.11 - 2020-09-22

_Full changeset and discussions: [#94](https://github.com/openfisca/country-template/pull/94)._

### Fixed

- Fix `make test` warning by updating OpenFisca test command

## 3.9.10 - 2020-02-22

_Full changeset and discussions: [#86](https://github.com/openfisca/country-template/pull/86)._

### Fixed

- Fix installation and building operations by fixing the bootstrap script

## 3.9.9 - 2020-02-11

_Full changeset and discussions: [#85](https://github.com/openfisca/country-template/pull/85)._

### Added

- Add `make serve-local` command to Makefile

## 3.9.8 - 2020-02-01

_Full changeset and discussions: [#83](https://github.com/openfisca/country-template/pull/83)._

### Added

- Add additional example JSON file

## 3.9.7 - 2020-01-27

_Full changeset and discussions: [#80](https://github.com/openfisca/country-template/pull/80)._

### Changed

- Upgrade `autopep8`

## 3.9.6 - 2019-04-24

_Full changeset and discussions: [#78](https://github.com/openfisca/country-template/pull/78)._

### Added

- Declare package compatible with Core v34

## 3.9.5 - 2019-04-15

_Full changeset and discussions: [#76](https://github.com/openfisca/country-template/pull/76)._

### Added

- Declare package compatible with Core v32

## 3.9.4 - 2019-04-15

_Full changeset and discussions: [#75](https://github.com/openfisca/country-template/pull/75)._

### Changed

- Upgrade `autopep8`

## 3.9.3 - 2019-04-08

_Full changeset and discussions: [#73](https://github.com/openfisca/country-template/pull/73)._

### Changed

- Upgrade `autopep8`

## 3.9.2 - 2019-04-08

_Full changeset and discussions: [#71](https://github.com/openfisca/country-template/pull/71)._

### Changed

- Upgrade `flake8` and `pycodestyle`

## 3.9.1 - 2019-04-05

_Full changeset and discussions: [#74](https://github.com/openfisca/country-template/pull/74)._

### Changed

- Explicit expected test output

## 3.9.0 - 2019-04-05

_Full changeset and discussions: [#72](https://github.com/openfisca/country-template/pull/72)._

### Added

- Declare package compatible with Core v31

## 3.8.0 - 2019-03-14

_Full changeset and discussions: [#69](https://github.com/openfisca/country-template/pull/69)._

### Added

- Declare package compatible with Core v27

## 3.7.0 - 2019-02-27

_Full changeset and discussions: [#68](https://github.com/openfisca/country-template/pull/68)._

### Changed

- Declare package compatible with Core v26
- Remove Python 2 checks from continuous integration

## 3.6.0 - 2018-12-05

_Full changeset and discussions: [#66](https://github.com/openfisca/country-template/pull/66)._

### Changed

- Adapt to OpenFisca Core v25
- Change the syntax of OpenFisca YAML tests

## 3.5.4 - 2018-11-22

_Full changeset and discussions: [#65](https://github.com/openfisca/country-template/pull/65)._

### Changed

- Update links to the doc

## 3.5.3 - 2018-11-13

_Full changeset and discussions: [#64](https://github.com/openfisca/country-template/pull/64)._

### Added

- Document housing tax

## 3.5.2 - 2018-10-30

_Full changeset and discussions: [#59](https://github.com/openfisca/country-template/pull/59), [#62](https://github.com/openfisca/country-template/pull/62) and [#63](https://github.com/openfisca/country-template/pull/63)._

### Changed

- Test library against the packaged version instead of the source

## 3.5.1 - 2018-10-29

### Changed

- Update links to the doc

## 3.5.0 - 2018-10-17

_Full changeset and discussions: [#58](https://github.com/openfisca/country-template/pull/58)._

### Changed

- In the `/spec` Web API route, use examples that apply to this country package

## 3.4.0 - 2018-10-12

### Added

- Introduce `code_postal` variable

## 3.3.2 - 2018-10-02

### Changed

- Update entities labels

## 3.3.1 - 2018-10-02

### Added

- Add documentation to `benefits` parameters
- Add documentation to `housing_allowance`

## 3.3.0 - 2018-08-15

_Full changeset and discussions: [#51](https://github.com/openfisca/country-template/pull/51)._

### Changed

- Make package compatible with OpenFisca Core v24
- Rename development dependencies from `test` to `dev`

## 3.2.3 - 2018-08-01

_Full changeset and discussions: [#50](https://github.com/openfisca/country-template/pull/50)._

### Changed

- Fix repository URL in package metadata

## 3.2.2 - 2018-07-16

_Full changeset and discussions: [#49](https://github.com/openfisca/country-template/pull/49)._

### Added

- Implement housing tax minimal amount
- Add metadata to parameters

## 3.2.1 - 2018-06-09

_Full changeset and discussions: [#47](https://github.com/openfisca/country-template/pull/47)._

### Added

- Make boostrap script portable

## 3.2.0 - 2018-06-06

_Full changeset and discussions: [#43](https://github.com/openfisca/country-template/pull/43)._

### Fixed

- Improve reliability and accuracy of `age` formula
- Improve variables comments

## 3.1.3 - 2018-05-29

_Full changeset and discussions: [#37](https://github.com/openfisca/country-template/pull/37)._

### Changed

- Upgrade openfisca.org references to HTTPS

## 3.1.2 - 2018-05-28

_Full changeset and discussions: [#38](https://github.com/openfisca/country-template/pull/38)._

### Added

- Add situation example using YAML

## 3.1.1 - 2018-05-21

_Full changeset and discussions: [#44](https://github.com/openfisca/country-template/pull/44)._

### Changed

- Continuously deploy Python3 package

## 3.1.0 - 2018-05-21

_Full changeset and discussions: [#41](https://github.com/openfisca/country-template/pull/41)._

### Added

- Make package compatible with Python 3

## 3.0.2 - 2018-05-01

_Full changeset and discussions: [#37](https://github.com/openfisca/country-template/pull/37)._

### Changed

- Declare package compatible with OpenFisca Core v23

## 3.0.1 - 2018-04-17

_Full changeset and discussions: [#39](https://github.com/openfisca/country-template/pull/39)._

### Changed

- Declare package compatible with OpenFisca Core v22

## 3.0.0 - 2018-04-10

_Full changeset and discussions: [#34](https://github.com/openfisca/country-template/pull/34)._

### Fixed

- **Breaking:** Fix spelling by renaming `accomodation_size` variable to `accommodation_size`
- Improve spelling

## 2.1.0 - 2018-02-06

_Full changeset and discussions: [#29](https://github.com/openfisca/country-template/pull/29) [#30](https://github.com/openfisca/country-template/pull/30)._

### Added

- Introduce `age_of_retirement` parameter
- Introduce `pension` variable

## 2.0.1 - 2018-01-11

_Full changeset and discussions: [#24](https://github.com/openfisca/country-template/pull/24) and [#27](https://github.com/openfisca/country-template/pull/27)._

### Changed

- **Breaking:**: upgrade to Core v21; see more on the OpenFisca-Core [changelog](https://github.com/openfisca/openfisca-core/blob/enums-perfs/CHANGELOG.md#2102-589-600-605
- **Breaking:**: introduce the use of a string identifier instead of indexes and phrases to reference Enum items; when setting an Enum (e.g. `housing_occupancy_status`), set the relevant string identifier (e.g. `free_lodger`)
- **Breaking:** the default value must be indicated for each Enum variable instead of being implicitly the first item

## 1.4.0 - 2017-11-06

_Full changeset and discussions: [#26](https://github.com/openfisca/country-template/pull/26)._

### Changed

- Upgrade to Core v20

## 1.3.2 - 2017-10-26

_Full changeset and discussions: [#25](https://github.com/openfisca/country-template/pull/25)._

### Changed

- Declare package compatible with OpenFisca Core v19

## 1.3.1 - 2017-10-13

_Full changeset and discussions: [#23](https://github.com/openfisca/country-template/pull/23)._

### Changed

- Declare package compatible with OpenFisca Core v18

## 1.3.0 - 2017-10-09

_Full changeset and discussions: [#22](https://github.com/openfisca/country-template/pull/22)._

### Added

- Introduce `total_benefits`
- Introduce `total_taxes`
- Introduce situation examples: `from openfisca_country_template.situation_examples import single, couple`

## 1.2.7 - 2017-09-12

_Full changeset and discussions: [#21](https://github.com/openfisca/country-template/pull/21)._

### Fixed

- Use the technical documentation new address

## 1.2.6 - 2017-08-30

_Full changeset and discussions: [#20](https://github.com/openfisca/country-template/pull/20)._

### Added

- Document entities

## 1.2.5 - 2017-08-28

_Full changeset and discussions: [#17](https://github.com/openfisca/country-template/pull/17)._

### Changed

- Adapt to version `17.0.0` of Openfisca-Core
- Transform XML parameter files to YAML parameter files

## 1.2.4 - 2017-08-04

_Full changeset and discussions: [#16](https://github.com/openfisca/country-template/pull/16)._

### Added

- Introduce `housing_occupancy_status`
- Take the housing occupancy status into account in the housing tax

## 1.2.3 - 2017-07-04

_Full changeset and discussions: [#9](https://github.com/openfisca/country-template/pull/9)._

### Changed

- Adapt to version `15.0.0` of Openfisca-Core
- Rename Variable attribute `url` to `reference`

## 1.2.2 - 2017-06-21

_Full changeset and discussions: [#12](https://github.com/openfisca/country-template/pull/12)._

### Changed

- Allow to declare a yearly amount for `salary`
- The yearly amount will be spread over the months contained in the year

## 1.2.1 - 2017-06-13

_Full changeset and discussions: [#11](https://github.com/openfisca/country-template/pull/11)._

### Changed

- Make `make test` command not ignore failing tests

## 1.2.0 - 2017-06-12

_Full changeset and discussions: [#10](https://github.com/openfisca/country-template/pull/10)._

### Changed

- Upgrade OpenFisca-Core
- Update the way we define formulas start dates and variables stop dates
- Update the naming conventions for variable formulas

## 1.1.0 - 2017-05-31

_Full changeset and discussions: [#7](https://github.com/openfisca/country-template/pull/7)._

### Added

- Add a reform modifying the brackets of a scale
- Show how to add, modify and remove a bracket
- Add corresponding tests

## 1.0.0 - 2017-05-17

_Full changeset and discussions: [#4](https://github.com/openfisca/country-template/pull/4)._

### Added

- Build the skeleton of the tax and benefit system
