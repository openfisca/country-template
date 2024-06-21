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

The impact on users of each change to the codebase is documented in the [`CHANGELOG.md`](./CHANGELOG.md) file. This constraint is validated automatically in CI. It is thus required to fill in the changelog when opening a pull request.

#### Changes that impact users

All changes to the codebase that impact users must be documented in the [`CHANGELOG.md`](./CHANGELOG.md) file, following the [Common Changelog](https://common-changelog.org) format with these additional specifications:

1. The `Unreleased` section of [Keep a Changelog](https://keepachangelog.com/en/1.0.0/) must be added in the changelog with the addition of a tag to specify which type of release should be published and to foster discussions about it inside pull requests. This tag should be one of the SemVer keywords, within brackets: `[patch]`, `[minor]` or `[major]`. _For example: `## Unreleased [minor]`._
2. Changes should be a single sentence with a leading capital and no closing punctuation, following [Common Changelog examples](https://common-changelog.org/#3-writing). _For example: `Correct calculation of family benefits in the case of twins born on a leap year`._
3. Each listed change must provide an actionable way to adapt the user’s codebase, either directly in the changelog or through instructions or links. _For example: `Group all company taxes in the new “business” category; rename all “company.xx” parameters to “business.xx”`._
4. Since each release is produced automatically from a single pull request, the [notice](https://common-changelog.org/#23-notice) links to the source pull request rather than [references](https://common-changelog.org/#242-references), which would always reference the same pull request. References can link to relevant parts of an RFC, decision record, or diff. **This notice is automatically generated by the CI during the release process and should not be added manually.**

#### Changes that do not impact users

Some changes are [not functional](https://common-changelog.org/#32-remove-noise) and do not impact users, such as changes in tooling, README or CI workflows. Such changes do not need to trigger a release, and the git history is sufficient to provide information to contributors. Such changesets must be clearly indicated by adding the following content in its entirety to the changelog:

```plaintext
## Unreleased [no-release]

_Modifications made in this changeset do not add, remove or alter any behavior, dependency, API or functionality of the software. They only change non-functional parts of the repository, such as the README file or CI workflows._
```

This entry will be automatically deleted by the CI after merging.
