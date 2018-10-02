# Changelog

### 3.3.2

* Minor change
* Details:
  - Update entities labels

### 3.3.1 - [#53](https://github.com/openfisca/country-template/pull/53)

* Minor change
* Details:
  - Add `documentation` to parameters: `benefits` node and `benefits/housing_allowance`
  - Add documentation to `housing_allowance` variable and formula

### 3.3.0 - [#51](https://github.com/openfisca/country-template/pull/51)

* Technical change
  - Make package compatible with OpenFisca Core v24
  - Rename development dependencies from `test` to `dev`:

### 3.2.3 - [#50](https://github.com/openfisca/country-template/pull/50)

* Minor change
* Details:
  - Fix repository URL in package metadata

### 3.2.2 - [#49](https://github.com/openfisca/country-template/pull/49)

* Tax and benefit system evolution.
* Impacted periods: all.
* Impacted areas: `taxes`
* Details:
  - Implement housing tax minimal amount

<!-- -->

* Minor change
* Details:
  - Add metadata to parameters

### 3.2.1 - [#47](https://github.com/openfisca/country-template/pull/47)

* Minor change.
* Details:
  - Make boostrap script portable.

## 3.2.0 - [#43](https://github.com/openfisca/country-template/pull/43)

* Tax and benefit system evolution.
* Impacted periods: all.
* Impacted areas: `demographics`
* Details:
  - Improve reliability and accuracy of `age` formula
  - Improve variables comments

### 3.1.3 - [#37](https://github.com/openfisca/country-template/pull/37)

* Minor change.
* Details:
  - Upgrade openfisca.org references to HTTPS.

### 3.1.2 - [#38](https://github.com/openfisca/country-template/pull/38)

* Minor change.
* Details:
  - Add situation example using YAML

### 3.1.1 - [#44](https://github.com/openfisca/country-template/pull/44)

* Technical improvement.
* Details:
  - Continuously deploy Python3 package.

## 3.1.0 - [#41](https://github.com/openfisca/country-template/pull/41)

* Technical improvement.
* Details:
  - Make package compatible with Python 3

### 3.0.2 - [#37](https://github.com/openfisca/country-template/pull/37)

* Technical change.
* Declare package compatible with OpenFisca Core v23

### 3.0.1 - [#39](https://github.com/openfisca/country-template/pull/39)

* Technical change.
* Declare package compatible with OpenFisca Core v22

# 3.0.0 - [#34](https://github.com/openfisca/country-template/pull/34)

#### Breaking change

* Tax and benefit system evolution.
* Impacted periods: all.
* Impacted areas: `housing`
* Details:
  - Fix spelling by renaming `accomodation_size` variable to `accommodation_size`

#### Other changes

* Minor change.
* Impacted areas: no functional impact.
* Details:
  - Improve spelling

## 2.1.0 - [#29](https://github.com/openfisca/country-template/pull/29) [#30](https://github.com/openfisca/country-template/pull/30)

* Tax and benefit system evolution
* Impacted areas:
  - Parameters `general`
  - Variables `benefits`
* Details:
  - Add a parameter and a variable with non ascii characters
    - Introduce `age_of_retirement` parameter
    - Introduce `pension` variable

## 2.0.1 - [#24](https://github.com/openfisca/country-template/pull/24) [#27](https://github.com/openfisca/country-template/pull/27)

_Note: the 2.0.0 version has been unpublished due to performance issues_

#### Breaking change

* Details:
  - Upgrade to Core v21
  - Introduce the use of a string identifier to reference Enum items.
  - When setting an Enum (e.g. housing_occupancy_status), set the relevant string identifier (e.g. `free_lodger`). Indexes (e.g.`2`) and phrases (e.g. `Free Lodgers`) cannot be used anymore.
  - The default value is indicated for each Enum variable instead of being implicitly the first item of the enum.

#### Web API request/response

Before:

```
"persons": {
    "Bill": {}
},
"households": {
    "_": {
        "parent": ["Bill"]
        "housing_occupancy_status": "Free Lodger"
    }
}
```
Now:

```
"persons": {
    "Bill": {}
},
"households": {
    "_": {
        "parent": ["Bill"]
        "housing_occupancy_status": "free_lodger"
    }
}
```

#### YAML testing
Before:

```
name: Household living in a 40 sq. metres accommodation while being free lodgers
  period: 2017
  input_variables:
    accommodation_size:
      2017-01: 40
    housing_occupancy_status:
      2017-01: 2
  output_variables:
    housing_tax: 0
```
Now:

```
name: Household living in a 40 sq. metres accommodation while being free lodgers
  period: 2017
  input_variables:
    accommodation_size:
      2017-01: 40
    housing_occupancy_status:
      2017-01: free_lodger
  output_variables:
    housing_tax: 0
```

#### Python API

When calculating an enum variable in Python, the output will be an [EnumArray](http://openfisca.readthedocs.io/en/latest/enum_array.html#module-openfisca_core.indexed_enums).

See more on the OpenFisca-Core [changelog](https://github.com/openfisca/openfisca-core/blob/enums-perfs/CHANGELOG.md#2102-589-600-605).

## 1.4.0 - [#26](https://github.com/openfisca/country-template/pull/26)

* Technical improvement
* Details:
  - Upgrade to Core v20

### 1.3.2 - [#25](https://github.com/openfisca/country-template/pull/25)

* Declare package compatible with OpenFisca Core v19

### 1.3.1 - [#23](https://github.com/openfisca/country-template/pull/23)

* Technical improvement
* Details:
  - Declare package compatible with OpenFisca Core v18

## 1.3.0 - [#22](https://github.com/openfisca/country-template/pull/22)

* Tax and benefit system evolution
* Impacted periods: all
* Impacted areas: `stats`
* Details:
  - Introduce `total_benefits`
  - Introduce `total_taxes`

<!-- -->

* Minor change
* Details:
  - Introduce situation examples
    - These examples can be imported with: `from openfisca_country_template.situation_examples import single, couple`

## 1.2.7 - [#21](https://github.com/openfisca/country-template/pull/21)

* Minor change
  - Use the technical documentation new address

## 1.2.6 - [#20](https://github.com/openfisca/country-template/pull/20)

* Minor change
  - Document entities

## 1.2.5 - [#17](https://github.com/openfisca/country-template/pull/17)

* Technical improvement
* Details:
  - Adapt to version `17.0.0` of Openfisca-Core
  - Transform XML parameter files to YAML parameter files.

## 1.2.4 - [#16](https://github.com/openfisca/country-template/pull/16)

* Tax and benefit system evolution
* Details
  - Introduce `housing_occupancy_status`
  - Take the housing occupancy status into account in the housing tax

## 1.2.3 - [#9](https://github.com/openfisca/country-template/pull/9)

* Technical improvement: adapt to version `15.0.0` of Openfisca-Core
* Details:
  - Rename Variable attribute `url` to `reference`

## 1.2.2 - [#12](https://github.com/openfisca/country-template/pull/12)

* Tax and benefit system evolution
* Details
  - Allow to declare a yearly amount for `salary`.
  - The yearly amount will be spread over the months contained in the year

## 1.2.1 - [#11](https://github.com/openfisca/country-template/pull/11)

* Technical improvement
* Details:
  - Make `make test` command not ignore failing tests.

## 1.2.0 - [#10](https://github.com/openfisca/country-template/pull/10)

* Technical improvement
* Details:
  - Upgrade OpenFisca-Core
    - Update the way we define formulas start dates and variables stop dates.
    - Update the naming conventions for variable formulas.
    - See the [OpenFisca-Core Changelog](https://github.com/openfisca/openfisca-core/blob/master/CHANGELOG.md#1400---522).

## 1.1.0 - [#7](https://github.com/openfisca/country-template/pull/7)

* Tax and benefit system evolution
* Impacted periods: from 2013-01-01
* Impacted areas:
   - Reform: `modify_social_security_taxation`
* Details:
  - Add a reform modifying the brackets of a scale
      - Show how to add, modify and remove a bracket.
      - Add corresponding tests.

# 1.0.0 - [#4](https://github.com/openfisca/country-template/pull/4)

* Tax and benefit system evolution.
* Impacted periods: all.
* Impacted areas:
  - `benefits`
  - `demographics`
  - `housing`
  - `income`
  - `taxes`
* Details:
  - Build the skeleton of the tax and benefit system
