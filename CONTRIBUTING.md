# Contributing to Thycotic.SecretServer

Thycotic.SecretServer is an open-source project and welcomes contributions from the community -- you! There are many ways to contribute, from improving the documentation, submitting bug reports and feature requests, or writing code incorporated into Thycotic.SecretServer itself.

## Bug Reports

Suppose you have found a bug in Thycotic.SecretServer, first ensure you are testing against the [latest release](https://github.com/thycotic-ps/thycotic.secretserver/releases/latest) - your issue may have already been fixed. If not, **search** our [issues list](https://github.com/thycotic-ps/thycotic.secretserver/issues) on GitHub in case a similar issue has already been opened.

If you can include a reproduction of the bug and details on your environment (e.g., Secret Server version, configurations, environment information) will be very helpful. A small test case which we can run to confirm the bug, if possible, will aid in finding and fixing the problem.

Provide as much detail as you can.

## Feature Requests

If you find yourself wishing for a function or feature that does not exist in Thycotic.SecretServer, you are probably not alone. There are bound to be other Secret Server admins or users with similar needs. Open an issue on our [issues list](https://github.com/thycotic-ps/thycotic.secretserver/issues) on GitHub, which describes the feature you would like to see, why you need it, and how it should work.

Add 👍🏻 reactions to created Feature Request will prioritize where our efforts need to be placed on the feature requests.

## Contributing documentation and code changes

If you would like to contribute a new feature or a bug fix to Thycotic.SecretServer, please discuss your idea first on the GitHub issue. If there is no issue created, please open one. It may be that somebody is already working on it or that there are particular complexities that you should know about before starting the implementation. There are often several ways to fix a problem, and it is essential to find the right approach before spending time on a PR that cannot be merged.

We add the [help-wanted](https://github.com/thycotic-ps/thycotic.secretserver/labels/help-wanted) label to existing GitHub issues for which community contributions are welcome.

## Fork and Clone the repository

You will need to fork this repository to your local machine. See [github help page](https://help.github.com/articles/fork-a-repo) for help.

## Submitting your changes

Once your changes and tests are ready to submit for review:

1. Test your changes

    [Pester](https://pester.dev) (Pester 5.1+) is used as the testing suite for the module. Run the test for the module or the specific function to make sure nothing is broken.

    Since the module's testing framework cannot be run (at this time) in an automated manner with each PR, we request that you run the tests locally and provide an indication (screenshot or output content) in the PR.

    > If your change is altering the module's functionality or function, this requires explicit approval from maintainer(s) before being submitted as a PR.

2. Rebase your changes

    Update your local repository with the most recent code from the main Thycotic.Secret repository, and rebase your branch on top of the latest master branch. We prefer your initial changes to be squashed into a single commit. Later, if we ask you to make changes, add them as separate commits; this makes reviewing the changes easier. As a final step before merging, we will either ask you to squash all commits yourself.

3. Submit a pull request

    Push your local changes to your forked copy of the repository and [submit a pull request](https://help.github.com/articles/using-pull-requests). In the pull request, choose a title that sums up the changes you have made, and in the body, provide more details about what your changes do. Also, mention the number of issues where the discussion has taken place, e.g., `Fixes #143` or `Closes #143`.

    > **Every** pull request requires an associated issue to be linked to it.

    > **Every** pull request will require the inclusion of the CHANGELOG file with your change and referenced issue. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

Then sit back and wait. There will probably be a discussion about the pull request and, if any changes are needed, we would love to work with you to get your pull request merged into Thycotic.SecretServer.

Please adhere to the general guideline that you should never force push to a publicly shared branch. Once you have opened your pull request, you should consider your branch publicly shared. Instead of force pushing, you can add incremental commits; this is generally easier on your reviewers. If you need to pick up changes from master, you can merge master into your branch. A reviewer might ask you to rebase a long-running pull request, in which case force pushing is okay for that request. Note that squashing at the end of the review process should also not be done, that can be done when the pull request is [integrated via GitHub](https://github.com/blog/2141-squash-your-commits).

## Test Environment Setup

The test framework for this module utilizes Pester 5.1+ and includes both unit and integration tests. The integration tests require a properly licensed Secret Server.

🚨
**Tests about folders and secrets _will be_ restricted to work against a specific parent folder (`tss_module_testing`). Function tests that affect or create objects outside of this will be restricted to mocking (where feasible). It is recommended to test against a test environment.**

🚨
**You accept the risk of running these tests against your production environment.**

### Prerequisites

Test about secrets and folders require a specific secret folder to exists: `tss_module_testing`.

An export XML file is provided and can be found under [tests/test_data](/tests/test_data). There is an included test template that needs to be added to Secret Server ** before importing the XML of secrets**. An attachment test file is also included to attach to the secret referenced in the test **after secret import**.

It is recommended to create a local Secret Server user as an application account, granting it `tss_module'_testing` for folder and secrets. Utilize this new account for running the Pester tests.

<img src="https://user-images.githubusercontent.com/11204251/103263755-64b8e080-496e-11eb-8e63-2c02c225f504.png" width="188" height="125" alt="test folder structure">

### Pester

The test is written for Pester 5.1, minimum, version and will not run on a lower version due to syntax and framework changes made to that module. Documentation for Pester can be found [here](https://pester.dev).

### Limitations

**To run the full gauntlet of tests for the module will require Administrator role permissions to Secret Server.** At a future time, a large portion of tests will include mocking instead of direct integration tests to make this easier.

Some tests do not have direct integration tests because of external systems or resources required to use them (e.g., Distributed Engines). In some cases, where feasible, mocking is used to expand the unit test coverage as much as possible. Mocking will be a large focus on tests that can potentially break an installation.

### `Constants.ps1` File

The `constants` file is utilized by the test to indicate the following:

- Secret Server URL
- Secret Server User credential
- Utilize Windows Authentication (setting `$tssTestUsingWindowsAuth = $true`)

If you save this file to your profile directly (`$env:USERPROFILE` or `$env:HOME` on Linux), you can include setting the needed variables directly.

The file will check if `$env:USERPROFILE\constants.ps1` or `$env:HOME\constants.ps1` exists, and if it does, will dot-source the file instead of using the values from the repository's version.

## Contribution Help

Do you need help with a contribution? Please create a [new discussion](https://github.com/thycotic-ps/thycotic.secretserver/discussions/new) for the `Q&A : Contributors` category.
