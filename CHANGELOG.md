# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] -- 2021-xx-xx

### Added

* GitHub Action for testing import on cross-platforms (eb2e9bb89e0b7b3019b3b97b0569faddecca7234)

### Changed

* None

## [0.25.0] -- 2021-01-19

### Added

* `Set-TssSecret` - additional parameters for General settings [#12](https://github.com/thycotic-ps/thycotic.secretserver/issues/12) (aefb780)

### Changed

* Fixed name of functions: `Get-TssSecret`, `Get-TssSecretField`, `Remove-TssReportCategory` (8bd9e13)
* Fixed issue on `Find-TssSecret` for looking up via ID (2be2358)
* Fixed issue identified by test failure on `Test-TssVersion` (254d572)

## [0.24.0] -- 2021-01-14

### Added

* Add `ApiUrl` to `TssSession` class [#39](https://github.com/thycotic-ps/thycotic.secretserver/issues/39) (ce0aeba9)
* Added script to call tests, `runTests.ps1` (0f2fa357)
* Add `Get-TssReport` [#5](https://github.com/thycotic-ps/thycotic.secretserver/issues/5) (2630239)
* Add `Get-TssReportCategory` [#20](https://github.com/thycotic-ps/thycotic.secretserver/issues/20) (a76c89f)
* Add `Remove-TssReportCategory` [#40](https://github.com/thycotic-ps/thycotic.secretserver/issues/40) (7f11f4d)
* Add `New-TssReport` [#38](https://github.com/thycotic-ps/thycotic.secretserver/issues/38) (7776c60)

### Changed

* Adjust process to build API call, `New-TssSession` builds the API URL now [#39](https://github.com/thycotic-ps/thycotic.secretserver/issues/39) (ce0aeba9)
* Update tests to support PS7+ (a66f2f49)
* Adjusted `Get-TssVersion` and `Test-TssVersion`, refine property output (227585cd)
* Reorganized class and function files in the module (40f822e)

## [0.23.0] -- 2021-01-04

### Added

* Added verbose output to applicable commands to provide parameter and values (cfd5304)
* Added `GetSlugName()` on TssSecretTemplate class, pass in the display name and get the slug name (1cd1b98)
* Added restricted params to `Get-TssSecret` [#37](https://github.com/thycotic-ps/thycotic.secretserver/issues/37)
* Added `Get-TssSecretField` [#6](https://github.com/thycotic-ps/thycotic.secretserver/issues/6)

### Changed

* `Get-TssSecret` - renamed `GetValue()` method to `GetFieldValue()` to make it unique in TssSecret class (d740ae7)

## [0.22.0] -- 2020-12-30

### Added

* `Invoke-TssRestApi` - integration tests added (2ce6787)
* `Get-TssSecret` - add `GetValue()` to `TssSecret` class to allow easy access to field values on secrets (b73deb9)

### Changed

* `Find-TssSecret` - adjusted to include `/secrets/lookup/{id}` endpoint, part of [#16](https://github.com/thycotic-ps/thycotic.secretserver/issues/16) that was missed
* `Search-TssSecret` - address truncating output [#35](https://github.com/thycotic-ps/thycotic.secretserver/issues/35)

## [0.21.5] - 2020-12-29

### Added

* All parts for classes validate if a property does not exist, will now provide a warning with a link to create bug report (244ac1d)

### Changed

* `Get-TssFolder` - renamed `Recurse` to `GetChildrent`; updated tests (d12ac57)
* `Find-TssSecret` - fix output issue [#32](https://github.com/thycotic-ps/thycotic.secretserver/issues/32)
* `Get-TssSecret` - add new property to TssSecret class [#33](https://github.com/thycotic-ps/thycotic.secretserver/issues/33)

## [0.21.0] - 2020-12-28

### Added

* New function: `Test-TssVersion` [#22](https://github.com/thycotic-ps/thycotic.secretserver/issues/22)
* New function: `Find-TssSecret` [#16](https://github.com/thycotic-ps/thycotic.secretserver/issues/16)
* Added XML export of folders and secrets utilized by Pester Tests in repository (e42d9fc0)

### Changed

* `Get-TssVersion` - moved version endpoint call to part function [#22](https://github.com/thycotic-ps/thycotic.secretserver/issues/22)
* `Search-TssSecret` - fixed issue with validateset for HeartbeatStatus (6e5b7c37)
* `Get-TssFolder` - update class output type and test (3bfbded6)
* `Get-TssSecretTemplate` - updated to class output and tests [#31](https://github.com/thycotic-ps/thycotic.secretserver/issues/31)
* `Set-TssSecret` - update to include verbose output for Email settings (7bd7ac80)
* `Search-TssSecret` - updated to class output and tests [#30](https://github.com/thycotic-ps/thycotic.secretserver/issues/30)

## [0.20.0] - 2020-12-26

### Added

* Alias for Invoke-RestApi: `itra` (4286a415)
* Add CHANGELOG to repository (ba3eadf8)
* Added GitHub release to build process [#18](https://github.com/thycotic-ps/thycotic.secretserver/issues/18)
* Add IconUri, CompatiblePSEditions (a4bb233a)
* Support for external access token, example via Client SDK `tss.exe token` [#26](https://github.com/thycotic-ps/thycotic.secretserver/issues/26)

### Changed

* `Set-TssSecret` - updated help, added examples for email setting params (fc21c006)
* Standardized error handeling function calling `Invoke-TssRestApi` (7b6b8272)

## [0.19.0] - 2020-12-24

### Added

* `Get-TssVersion` added
* `Get-TssFolder` added
* `Get-TssSecret` add alias `gts`
* `New-TssSession` add alias `nts`
* `Get-TssSecret` add example for using `GetCredential()` method
* `Set-TssSecret` added parameters for setting Email Settings on secrets

### Changed

* Update `about_tsssecret`

## [0.18.0] - 2020-12-21

### Added

* `Get-TssSession` added `GetCredential()` method
* `Set-TssSession` add `Clear` param to clear field values

### Changed

* `Get-TssSession` updated to use `TssSecret` class

## [0.17.0] - 2020-12-15

### Added

* `Get-TssSession` - add integration test, set OutputType

### Changed

* `Invoke-TssRestApi` - parse response for code/message API error object
* Functions - adjust error handling on endpoint calls

## [0.16.0] - 2020-12-14

### Changed

* `Set-TssSession `- Correct WhatIf output

## [0.15.0] - 2020-12-14

### Added

* `TssSession` - added methods: `SessionRefresh()` and `SessionExpire()`
* `TssSession` - added help `about_tsssession`

### Changed

* `TssSession` - Updated properties


## [0.14.0] - 2020-12-11

### Added

* Add test for `Get-TssSecretTemplate`
* Added test run to build process

### Changed

* `Search-TssSecret` - Added `IncludeInactive` parameter

## [0.13.0] - 2020-12-11

### Added

* Added `TssSession` class
* Added unit test
* Added format and types file
* New `TssSession` parameter added to all public functions
* `Search-TssSecret` - Added `IncludeInactive` parameter

### Changed

* Removed `Get-TssSession`
* `Find-TssSecret` renamed to `Search-TssSecret`
* `Get-TssSecret` - Modified output

## [0.12.0] - 2020-10-11

### Added

* `New-TssSession` - add comment-based help
* `Get-TssSession` - add comment-based help

### Changed

* `TestTssSession` - update throw message

## [0.11.0] - 2020-09-22

### Changed

* Rename `TssSession` object property `AuthToken` to `AccessToken`
* Created build script

## [0.10.0] - 2020-07-28

### Changed

* `Find-TssSecret` fix bug on restricted

## [0.9.0] - 2020-07-28

### Changed

* `Find-TssSecret` set to include restricted

## [0.8.0] - 2020-07-28

### Added

* Added `Get-TssSecretTemplate`

## [0.7.0] - 2020-07-28

### Added

* Added `Set-TssSecret`
* Added TSL1.2 setting for Secret Server Cloud
* `Disable-TssSecret` add status property

### Changed

* `Find-TssSecret` format output
* `Get-TssSecret` - format doc example, rework workflow, error handling, add Comment support

## [0.6.0] - 2020-07-28

### Added

* Added alias `Remove-TssSecret`

### Changed

* Rename `Remove-TssSecret` to `Disable-TssSecret`

## [0.5.0] - 2020-07-28

### Added

* Added `Remove-TssSecret`

## [0.4.0] - 2020-07-28

### Added

* Added `Find-TssSecret`

## [0.3.0] - 2020-07-28

### Changed

* Enhancement to `New-TssSession` (parameter and session validating)

## [0.2.0] - 2020-07-05

### Added

* Added `Invoke-TssRestApi`
* Added `New-TssSession`

## [0.1.0] - 2020-06-29

Initial Commit
