# Contributing to Thycotic.SecretServer

Thycotic.SecretServer is an open-source project and welcomes contributions from the community -- you! There are many ways to contribute, from improving the documentation, submitting bug reports and feature requests, or writing code incorporated into the module.

## Bug Reports

Suppose you have found a bug in Thycotic.SecretServer, first ensure you are testing against the [latest release](https://github.com/thycotic-ps/thycotic.secretserver/releases/latest) - your issue may have already been fixed. If not, **search** our [issues list](https://github.com/thycotic-ps/thycotic.secretserver/issues) on GitHub in case a similar issue has already been opened.

If you can include a reproduction of the bug and details on your environment (e.g., Secret Server version, configurations, environment information) will be very helpful. A small test case which we can run to confirm the bug, if possible, will aid in finding and fixing the problem (e.g., export of a secret template and secret).

Provide as much detail as you can.

## Feature Requests

If you find yourself wishing for a function or feature that does not exist in Thycotic.SecretServer, you are probably not alone. There are bound to be other Secret Server admins or users with similar needs. Open an issue on our [issues list](https://github.com/thycotic-ps/thycotic.secretserver/issues) on GitHub, which describes the feature you would like to see, why you need it, and how it should work.

Add 👍🏻 reactions to created Feature Request will prioritize our efforts to be placed on the feature requests.

## Contributing documentation and code changes

If you would like to contribute a new feature or a bug fix to Thycotic.SecretServer, please discuss your idea first on the GitHub issue. If there is no issue created, please open one. It may be that somebody is already working on it or that there are particular complexities that you should know about before starting the implementation. There are often several ways to fix a problem, and it is essential to find the right approach before spending time on a PR that cannot be merged.

We add the [help-wanted](https://github.com/thycotic-ps/thycotic.secretserver/labels/help-wanted) label to existing GitHub issues for which community contributions are welcome.

## Fork and Clone the repository

You will need to fork this repository to your local machine. See [github help page](https://help.github.com/articles/fork-a-repo) for help.

## Please Consider Your Commit Messages

The git history of a branch is utilized in building the CHANGELOG for the project. Please be considerate of this when you are committing to your fork to submit a PR.

More info: [How to Write a Git Commit Message](https://chris.beams.io/posts/git-commit/)

## C# Library

All class types used in the module are in a C# class library. There are a few binary commands (cmdlets) written, but those are rare to change.

The class library is broken into two main namespaces:

- `Thycotic.SecretServer.Cmdlets`
- `Thycotic.PowerShell.<TagName>`

The classes utilized as output for the commands are named after the tag for the objects. e.g., `Thycotic.PowerShell.Secrets` namespace contains all the objects under the Secrets tag for endpoints such as Get-TssSecret, Get-TssSecretAudit.

The classes are put into their own `cs` file and named based on the class name used. If you want to find the class file for a Secret, you will go to `src\Thycotic.SecretServer\classes\secrets\Secret.cs`.

### Building Library

The `InvokeBuild` module is utilized to automate building the library and publishing the module (both pre-release on GitHub and to the PS Gallery).

The `build.ps1` script is at the root of the project. The `build.library.ps1` hosts the dotnet code used to compile the library itself.

In the main build script, the supported Configurations: Debug, Release, and Prerelease. _The last two are only used by the maintainers._

To build the library for debugging or local testing, simply run the following command at the root of the project:

```powershell
Invoke-Build -File .\build.ps1 -Configuration Debug
```

## Submitting your changes

Once your changes and tests are ready to submit for review:

1. Test your changes

    [Pester](https://pester.dev) (Pester 5.1+) is used as the testing suite for the module. At this time, the tests for each command only provide for unit testing the parameters and output type.

    Secret Server offers the ability to have multiple configuration and environmental limitations. Therefore at this time, no integration tests are included for automatic testing. The maintainers will perform manual integration tests as required. Please include screenshots or verbose output of your testing if possible.

    > If your change alters the module's functionality or function, this requires explicit approval from maintainer(s) before being submitted as a PR.

2. Rebase your changes

    Update your local repository with the most recent code from the main Thycotic.Secret repository, and rebase your branch on top of the latest master branch. We prefer your initial changes to be squashed into a single commit. Later, if we ask you to make changes, add them as separate commits; this makes reviewing the changes easier. As a final step before merging, we will either ask you to squash all commits yourself.

3. Submit a pull request

    Push your local changes to your forked copy of the repository and [submit a pull request](https://help.github.com/articles/using-pull-requests). In the pull request, choose a title that sums up the changes you have made, and in the body, provide more details about what your changes do. Also, mention the number of issues where the discussion has occurred, e.g., `Fixes #143` or `Closes #143`.

    > **Every** pull request requires an associated issue to be linked to it.

    > **Every** pull request will require the inclusion of the CHANGELOG file with your change and referenced issue. The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/).

Then sit back and wait. There will probably be a discussion about the pull request and, if any changes are needed, we would love to work with you to get your pull request merged into Thycotic.SecretServer.

Please adhere to the general guideline that you should never force push to a publicly shared branch. Once you have opened your pull request, you should consider your branch publicly shared. Instead of force pushing, you can add incremental commits; this is generally easier on your reviewers. If you need to pick up changes from master, you can merge master into your branch. A reviewer might ask you to rebase a long-running pull request, in which case force pushing is okay for that request. Note that squash at the end of the review process should also not be done, which can be done when the pull request is [integrated via GitHub](https://github.com/blog/2141-squash-your-commits).

### Testing Framework - Pester

Each function is written with a Pester test that performs unit testing. The tests are compatible with Pester 5.1 and above. Documentation for Pester can be found [here](https://pester.dev).

### Limitations

Test at this time is in flux and being migrated to all unit tests.

## Contribution Help

Do you need help with a contribution? Please create a [new discussion](https://github.com/thycotic-ps/thycotic.secretserver/discussions/new) for the `Q&A : Contributors` category.
