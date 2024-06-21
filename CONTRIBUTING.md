# Contributing guidelines

First of all, thank you for wanting to contribute to OpenFisca! :smiley:

## Table of Contents

- [Workflow](#workflow)
  - [GitHub Flow](#github-flow)
  - [Peer reviews](#peer-reviews)
  - [Continous delivery](#continuous-delivery)
- [Advertising changes](#advertising-changes)
  - [Changelog](#changelog)
  - [Semantic versioning](#semantic-versioning)

- - -

## Workflow

### GitHub Flow

This project follows the [GitHub Flow](https://guides.github.com/introduction/flow/): all code contributions are submitted via a pull request towards the `main` branch.

Opening a Pull Request means requesting code to be merged. If the goal is only to discuss an implementation, it is preferred to share a link to the branch through other communication channels.

### Peer reviews

All pull requests must be reviewed by someone else than their original author.

In case of a lack of available reviewers and an urgency to merge, one may self-review after at least 24 hours have elapsed without working on the code to review.

To ensure a smooth review, pull requests should be accompanied by a clear description of the changeset they implement, and link to any relevant open issues.

### Continuous delivery

Continuous integration is used to release the package on every merge to the `main` branch.

Branch protection is active: a merge to the main branch can only take place once all tests pass in CI, and that the peer review policy has been fulfilled.

## Advertising changes

Users of this rules model integrate it with their own systems. OpenFisca models follow two standard mechanisms to minimise their maintenance costs and ensure the long-term viability of existing codebases, by advertising clearly API changes.

In the context of a Rules as Code model, the “API” is defined as the set of all rules that are exposed, even if the technical API itself does not change. For example, correcting the calculation of an already-modelled tax, implementing a new piece of legislation, or renaming a rule that can be calculated by users are all considered API changes.

### Semantic versioning

This model follows the [semantic versioning](http://semver.org/) specification: any change to the API surface impacts the version number, and the version number conveys API compatibility information. In the context of Rules as Code, here are the meanings of SemVer keywords:

- **Patch**: correcting or improving an existing calculation without changing the name nor parameter of any rule. These changes result in a drop-in replacement. _For example, updating minimum wage values following a yearly planned increase._
- **Minor**: adding a rule to the model. These changes are fully backwards-compatible, but need active work from users to benefit from them. _For example, adding a set of variables and parameters to the model following the enactment of a new law._
- **Major**: renaming or removing a variable from the model. Applying these changes exposes some users to a risk of their integration breaking if they do not check and potentially update their code. _For example, changing the naming convention of some area of legislation, including in the past._





### Changelog

openfisca-country_template changes must be understood by users who don't necessarily work on the code. The Changelog must therefore be as explicit as possible.

Each change must be documented with the following elements:

- On the first line appears as a title the version number, as well as a link towards the Pull Request introducing the change. The title level must match the incrementation level of the version.


> For instance :
> # 13.0.0 - [#671](https://example.com/repository/pull/671)
>
> ## 13.2.0 - [#676](https://example.com/repository/pull/676)
>
> ### 13.1.5 - [#684](https://example.com/repository/pull/684)

- The second line indicates the type of the change. The possible types are:
 - `Tax and benefit system evolution`: Calculation improvement, fix, or update. Impacts the users interested in calculations.
 - `Technical improvement`: Performances improvement, installing process change, formula syntax change… Impacts the users who write legislation and/or deploy their own instance.
 - `Crash fix`: Impact all reusers.
 - `Minor change`: Refactoring, metadata… Has no impact on users.

- In the case of a `Tax and benefit system evolution`, the following elements must then be specified:
  - The periods impacted by the change. To avoid any ambiguity, the start day and/or the end day of the impacted periods must be precised. For instance, `from 01/01/2017` is correct, but `from 2017` is not, as it is ambiguous: it is not clear wheter 2017 is included or not in the impacted period.
  - The tax and benefit system areas impacted by the change. These areas are described by the relative paths to the modified files, without the `.py` extension.

> For instance :
> - Impacted periods: Until 31/12/2015.
> - Impacted areas: `benefits/healthcare/universal_coverage`

- Finally, for all cases except `Minor Change`, the changes must be explicited by details given from a user perspective: in which case was an error or a problem was noticed ? What is the new available feature ? Which new behaviour is adopted.

> For instance:
>
> * Details :
>   - These variables now return a yearly amount (instead of monthly):
>     - `middle_school_scholarship`
>     - `high_school_scholarship`
>   - _The previous monthly amounts were just yearly amounts artificially divided by 12_
>
> or :
>
> * Details :
>  - Use OpenFisca-Core `12.0.0`
>  - Change the syntax used to declare parameters:
>      - Remove "fuzzy" attribute
>      - Remove "end" attribute
>      - All parameters are assumed to be valid until and end date is explicitely specified with an `<END>` tag

When a Pull Request contains several disctincts changes, several paragraphs may be added to the Changelog. To be properly formatted in Markdown, these paragraphs must be separated by `<!-- -->`.
