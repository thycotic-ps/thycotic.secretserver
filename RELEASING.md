# Releasing Thycotic.SecretServer

How branches, tags and releases are named, and the steps to cut a prerelease or a release. `build.ps1` enforces the naming rules, so a build that does not follow them stops before it publishes anything.

## Branches

| Branch | Purpose |
| --- | --- |
| `dev` | Integration branch. Every pull request targets `dev`. |
| `main` | The latest final release. Fast-forwarded to the release tag after each final release. Prereleases never touch it. |
| `release/X.Y.Z` | One per version, cut from `dev` when the version is ready for testing. Every prerelease and the final release of `X.Y.Z` is tagged on this branch. |
| `type/issue-slug` | Work branches. See below. |

### Work branches

Name a work branch `type/issue-slug`:

- `type` is the conventional-commit type of the change: `feat`, `fix`, `docs`, `chore`, `refactor` or `test`.
- `issue` is the number of the GitHub issue the change resolves. Every pull request needs an issue, so every branch has one.
- `slug` is a few lowercase words joined with hyphens.

Examples: `fix/474-nextpassword-verbose`, `feat/482-rest-cmdlets`, `docs/478-rollback-sha256`.

### Fixes during a release

Merge the fix to `dev` first, then cherry-pick it onto `release/X.Y.Z` with `git cherry-pick -x`, so the release branch never has a change that `dev` lacks.

### Hotfixes

Cut `release/X.Y.(Z+1)` from the `vX.Y.Z` tag, cherry-pick the fixes from `dev`, and release it like any other version.

## Versions and tags

| Item | Final release | Prerelease |
| --- | --- | --- |
| Manifest `ModuleVersion` | `X.Y.Z` | `X.Y.Z` |
| Manifest `PrivateData.PSData.Prerelease` | empty | `<label>N`, for example `rc1` |
| Git tag | `vX.Y.Z` | `vX.Y.Z-<label>N`, for example `v0.63.0-rc1` |
| GitHub release title | the tag name | the tag name |
| GitHub release | latest | marked as a pre-release |
| PowerShell Gallery | `X.Y.Z` | `X.Y.Z-<label>N`, offered only with `-AllowPrerelease` |

Prerelease labels, in order:

| Label | Meaning |
| --- | --- |
| `alpha` | Early build for validation. Cmdlet names, parameters and output can still change. |
| `beta` | Feature complete. Fixes only from here, though behavior can still change if testing finds a problem. |
| `rc` | Release candidate. The final release matches this build unless a reported issue needs a fix. |

`N` starts at 1 for each label and counts up: `alpha1`, `alpha2`, `rc1`. Use no dot or hyphen inside the label (`rc1`, not `rc.1`); the PowerShell Gallery accepts only letters and digits there.

## Cutting a prerelease

1. Cut the release branch from `dev`, or update it with cherry-picked fixes if it already exists:

    ```powershell
    git switch -c release/0.64.0 origin/dev
    ```

2. In `src/Thycotic.SecretServer.psd1`, set `ModuleVersion = '0.64.0'` and `Prerelease = 'rc1'`. Commit as `chore: 0.64.0-rc1`.
3. Make sure the `CHANGELOG.md` section for the version is complete, and write the release notes in `release.md` (ignored by git; `build.ps1` passes it to `gh release create`).
4. Push the branch with tracking: `git push -u origin release/0.64.0`.
5. Build and publish:

    ```powershell
    .\build.ps1 -Configuration Prerelease -GitHubPreTag rc1 -GalleryKey $key
    ```

    This tags `v0.64.0-rc1` on the current commit, creates the GitHub pre-release with the zip, and publishes `0.64.0-rc1` to the PowerShell Gallery. Leave out `-GalleryKey` to create only the GitHub pre-release.

## Cutting the final release

1. On `release/X.Y.Z`, clear `Prerelease` in the manifest. Commit as `chore: X.Y.Z`, and push.
2. Build and publish:

    ```powershell
    .\build.ps1 -Configuration Release -GalleryKey $key
    ```

3. Fast-forward `main` to the release, and merge the release branch back into `dev` so the version stamp and any release-only commits reach `dev`:

    ```powershell
    git push origin 'vX.Y.Z^{commit}:refs/heads/main'
    git switch dev; git merge --no-ff release/X.Y.Z; git push origin dev
    ```

    If the push to `main` is rejected as not a fast-forward, stop and ask a maintainer. Do not force-push `main`.

## What build.ps1 checks

For `Prerelease`, `Release` and `PSGalleryRetry` builds, `build.ps1` stops when:

- the current branch is not `release/X.Y.Z` for the manifest's `ModuleVersion`;
- the local branch has commits that are not pushed;
- `-GitHubPreTag` is not `alpha`, `beta` or `rc` followed by a number, or does not match the manifest's `Prerelease` (prerelease builds);
- the manifest still has a `Prerelease` value (release builds).
