# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] -- 2021-xx-xx

### Added

* GitHub Action for testing import on cross-platforms - [eb2e9bb](https://github.com/thycotic-ps/thycotic.secretserver/commit/eb2e9bb89e0b7b3019b3b97b0569faddecca7234)
* `Search-TssReportSchedule` [#47](https://github.com/thycotic-ps/thycotic.secretserver/issues/47) [ce1f9cc](https://github.com/thycotic-ps/thycotic.secretserver/commit/ce1f9cc798ce1e5c0f8df95e192dd5b116329cef)

### Changed

* `Search-TssReportSchedule` renamed class, added type [77b2a6f](https://github.com/thycotic-ps/thycotic.secretserver/commit/77b2a6f5f43acc00277d620037ff087e8a80555f)

## [0.25.0] -- 2021-01-19

### Added

* `Set-TssSecret` - additional parameters for General settings [#12](https://github.com/thycotic-ps/thycotic.secretserver/issues/12) [aefb780](https://github.com/thycotic-ps/thycotic.secretserver/commit/aefb780819223a3f4314cdd353effebd462b327d)

### Changed

* Fixed name of functions: `Get-TssSecret`, `Get-TssSecretField`, `Remove-TssReportCategory` [8bd9e13](https://github.com/thycotic-ps/thycotic.secretserver/commit/8bd9e1357e48c01e0b120f6a18bdf25cf3e0ac4c)
* Fixed issue on `Find-TssSecret` for looking up via [2be2358](https://github.com/thycotic-ps/thycotic.secretserver/commit/2be2358dcb790f57235875476f81e2f1c1e763dd)
* Fixed issue identified by test failure on `Test-TssVersion` [d5b95c0](https://github.com/thycotic-ps/thycotic.secretserver/commit/d5b95c03c9b4ea5eb9ede31e6e0d7c9a31103165)

## [0.24.0] -- 2021-01-14

### Added

* Add `ApiUrl` to `TssSession` class [#39](https://github.com/thycotic-ps/thycotic.secretserver/issues/39) [ce0aeba](https://github.com/thycotic-ps/thycotic.secretserver/commit/ce0aeba9eb62c338f90d65ede71ec873c115be69)
* Added script to call tests, `runTests.ps1` [0f2fa35](https://github.com/thycotic-ps/thycotic.secretserver/commit/0f2fa3577ccb63895ccc0ac9ced8f7b597c696ee)
* Add `Get-TssReport` [#5](https://github.com/thycotic-ps/thycotic.secretserver/issues/5) [2630239](https://github.com/thycotic-ps/thycotic.secretserver/commit/2630239ba1fd81267ce52ae19e705669be028b02)
* Add `Get-TssReportCategory` [#20](https://github.com/thycotic-ps/thycotic.secretserver/issues/20) [a76c89f](https://github.com/thycotic-ps/thycotic.secretserver/commit/a76c89f938ce247d50e78d40f06bb91d0a44016f)
* Add `Remove-TssReportCategory` [#40](https://github.com/thycotic-ps/thycotic.secretserver/issues/40) [7f11f4d](https://github.com/thycotic-ps/thycotic.secretserver/commit/7f11f4d5f4dc72f4c0fdc29a0dc3cb07125b7def)
* Add `New-TssReport` [#38](https://github.com/thycotic-ps/thycotic.secretserver/issues/38) [7776c60](https://github.com/thycotic-ps/thycotic.secretserver/commit/7776c6060e08fec303e447d7c88b8cac286209e7)

### Changed

* Adjust process to build API call, `New-TssSession` builds the API URL now [#39](https://github.com/thycotic-ps/thycotic.secretserver/issues/39) [ce0aeba](https://github.com/thycotic-ps/thycotic.secretserver/commit/ce0aeba9eb62c338f90d65ede71ec873c115be69)
* Update tests to support PS7+ [a66f2f4](https://github.com/thycotic-ps/thycotic.secretserver/commit/a66f2f491fbd574526ebde0457abeaf20766d804)
* Adjusted `Get-TssVersion` and `Test-TssVersion`, refine property output [227585c](https://github.com/thycotic-ps/thycotic.secretserver/commit/227585cdfb6c543459bf646aae1dfd87a2a1096a)
* Reorganized class and function files in the module [40f822e](https://github.com/thycotic-ps/thycotic.secretserver/commit/40f822e4d56b222aac141fc420b6adb6cbe784ee)

## [0.23.0] -- 2021-01-04

### Added

* Added verbose output to applicable commands to provide parameter and values [cfd5304](https://github.com/thycotic-ps/thycotic.secretserver/commit/cfd530436ae4f1b2e3f2dcc8e461cdbf9d31e5bc)
* Added `GetSlugName()` on TssSecretTemplate class, pass in the display name and get the slug name [1cd1b98](https://github.com/thycotic-ps/thycotic.secretserver/commit/1cd1b98f112df20d7db4cfc0ee5160c379466c77)
* Added restricted params to `Get-TssSecret` [#37](https://github.com/thycotic-ps/thycotic.secretserver/issues/37)
* Added `Get-TssSecretField` [#6](https://github.com/thycotic-ps/thycotic.secretserver/issues/6)

### Changed

* `Get-TssSecret` - renamed `GetValue()` method to `GetFieldValue()` to make it unique in TssSecret class [d740ae7](https://github.com/thycotic-ps/thycotic.secretserver/commit/d740ae7b50694b58813cd47e7b1f67aa42b2a1e1)

## [0.22.0] -- 2020-12-30

### Added

* `Invoke-TssRestApi` - integration tests added [2ce6787](https://github.com/thycotic-ps/thycotic.secretserver/commit/2ce6787b09b46d613f20467645c1f0192e6489dd)
* `Get-TssSecret` - add `GetValue()` to `TssSecret` class to allow easy access to field values on secrets [b73deb9](https://github.com/thycotic-ps/thycotic.secretserver/commit/b73deb9a1f5171ea29cac92c9b639cb74a18cf7e)

### Changed

* `Find-TssSecret` - adjusted to include `/secrets/lookup/{id}` endpoint, part of [#16](https://github.com/thycotic-ps/thycotic.secretserver/issues/16) that was missed
* `Search-TssSecret` - address truncating output [#35](https://github.com/thycotic-ps/thycotic.secretserver/issues/35)

## [0.21.5] - 2020-12-29

### Added

* All parts for classes validate if a property does not exist, will now provide a warning with a link to create bug report [244ac1d](https://github.com/thycotic-ps/thycotic.secretserver/commit/244ac1ddd9e0baf04609948f9a1a5a91dd3ece10)

### Changed

* `Get-TssFolder` - renamed `Recurse` to `GetChildrent`; updated tests [d12ac57](https://github.com/thycotic-ps/thycotic.secretserver/commit/d12ac57183d11134b0f6d6cce1c413b75826b0c9)
* `Find-TssSecret` - fix output issue [#32](https://github.com/thycotic-ps/thycotic.secretserver/issues/32)
* `Get-TssSecret` - add new property to TssSecret class [#33](https://github.com/thycotic-ps/thycotic.secretserver/issues/33)

## [0.21.0] - 2020-12-28

### Added

* New function: `Test-TssVersion` [#22](https://github.com/thycotic-ps/thycotic.secretserver/issues/22)
* New function: `Find-TssSecret` [#16](https://github.com/thycotic-ps/thycotic.secretserver/issues/16)
* Added XML export of folders and secrets utilized by Pester Tests in repository [e42d9fc](https://github.com/thycotic-ps/thycotic.secretserver/commit/e42d9fc035f3f52acc35129c2b1c57a8b14c6cba)

### Changed

* `Get-TssVersion` - moved version endpoint call to part function [#22](https://github.com/thycotic-ps/thycotic.secretserver/issues/22)
* `Search-TssSecret` - fixed issue with validateset for HeartbeatStatus [6e5b7c3](https://github.com/thycotic-ps/thycotic.secretserver/commit/6e5b7c37bd2ebc228d4c82dab22a2f81005d7d39)
* `Get-TssFolder` - update class output type and test [3bfbded](https://github.com/thycotic-ps/thycotic.secretserver/commit/3bfbded6ffd0c853f25b80698a189e5dac8342ab)
* `Get-TssSecretTemplate` - updated to class output and tests [#31](https://github.com/thycotic-ps/thycotic.secretserver/issues/31)
* `Set-TssSecret` - update to include verbose output for Email settings [7bd7ac8](https://github.com/thycotic-ps/thycotic.secretserver/commit/7bd7ac80b884fcf23a28dd1625b3a68812ffd8c8)
* `Search-TssSecret` - updated to class output and tests [#30](https://github.com/thycotic-ps/thycotic.secretserver/issues/30)

## [0.20.0] - 2020-12-26

### Added

* Alias for Invoke-RestApi: `itra` [4286a41](https://github.com/thycotic-ps/thycotic.secretserver/commit/4286a41514314252a1229caea7d939dc12335d42)
* Add CHANGELOG to repository (ba3eadf8)
* Added GitHub release to build process [#18](https://github.com/thycotic-ps/thycotic.secretserver/issues/18)
* Add IconUri, CompatiblePSEditions (a4bb233a)
* Support for external access token, example via Client SDK `tss.exe token` [#26](https://github.com/thycotic-ps/thycotic.secretserver/issues/26)

### Changed

* `Set-TssSecret` - updated help, added examples for email setting params [fc21c00](https://github.com/thycotic-ps/thycotic.secretserver/commit/fc21c006c891ab7ac55744a1bfd5c0fb26383780)
* Standardized error handeling function calling `Invoke-TssRestApi` [7b6b827](https://github.com/thycotic-ps/thycotic.secretserver/commit/7b6b82724d7f42cac95f166f1192ca7428f34b63)

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
