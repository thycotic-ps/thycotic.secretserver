# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] -- 2021-xx-xx

### Added

* None

### Changed

* None

## [0.31.2] -- 2021-02-18

### Added

* None

### Changed

* Fixed issue with using SDK Client integration from AllUsers scope [#83](https://github.com/thycotic-ps/thycotic.secretserver/issues/83) [981a988](https://github.com/thycotic-ps/thycotic.secretserver/commit/981a988b2a56e1d92e0c9a0e1a4747cf998a9341)

## [0.31.1] -- 2021-02-17

### Added

* None

### Changed

* Updated help for `Initialize-TssSdkClient` and `New-TssSession` [922200b](https://github.com/thycotic-ps/thycotic.secretserver/commit/922200bc6627546873368e38fc660d88db4fb54c)

## [0.31.0] -- 2021-02-17

### Added

* **SDK Client 1.5.0 (tss)** integration via `Initialize-TssSdkClient` and `New-TssSession` parameters: `-UseSdkClient`, `-ConfigPath` [#58](https://github.com/thycotic-ps/thycotic.secretserver/issues/58) [92a88af](https://github.com/thycotic-ps/thycotic.secretserver/commit/92a88afefe7123cc23858122c48b41dc3ef148e9)

### Changed

* `New-TssSession` update help examples [e95358b](https://github.com/thycotic-ps/thycotic.secretserver/commit/e95358b094a2860a1e292c691c0ca1b66d29c89f)
* `TssSession` and `TssSecretItem` about topic updates [f233d99](https://github.com/thycotic-ps/thycotic.secretserver/commit/f233d99f02d2d5a7ddcb01e32b5d52e89fdae2f1)
* 'Invoke-TssRestApi' updated help example [bf5d5da](https://github.com/thycotic-ps/thycotic.secretserver/commit/bf5d5da10f31958ddde11bdde41d696903e304ba)

## [0.30.0] -- 2021-02-15

### Added

* Windows Authentication support [#24](https://github.com/thycotic-ps/thycotic.secretserver/issues/24) [7eeb8d8](https://github.com/thycotic-ps/thycotic.secretserver/commit/7eeb8d87783833502c1e47650f66e611df71aae1)
* `Get-TssFolderAudit` [#61](https://github.com/thycotic-ps/thycotic.secretserver/issues/61) [e12c7ec](https://github.com/thycotic-ps/thycotic.secretserver/commit/e12c7ecf74cd2c73ff3342c6fa074d05dd3aa6b6)
* `Remove-TssFolderTemplate` [#67](https://github.com/thycotic-ps/thycotic.secretserver/issues/67) [381a0ee](https://github.com/thycotic-ps/thycotic.secretserver/commit/381a0ee046ac0fe01ef7eb801682a23adc46c599)
* `Get-TssFolderPermissionsStub` [#78](https://github.com/thycotic-ps/thycotic.secretserver/issues/78) [db5aed2](https://github.com/thycotic-ps/thycotic.secretserver/commit/db5aed22343a66e914b92d53fe51ff0df0fb1849)
* `Set-TssFolder` [#75](https://github.com/thycotic-ps/thycotic.secretserver/issues/75) [ed90de3](https://github.com/thycotic-ps/thycotic.secretserver/commit/ed90de318a19715f121b751b1e3d0d98d16d2ee4)
* `New-TssSession` add WhatIf support to resolve PSSA warning [cb5fd65](https://github.com/thycotic-ps/thycotic.secretserver/commit/cb5fd65f6c6074ae1f3f067ed3953286b453ab90)

### Changed

* `New-TssSession` - corrected TokenType with using `-AccessToken` parameter [26720ba](https://github.com/thycotic-ps/thycotic.secretserver/pull/73/commits/26720ba9d37b3f2c6c8986a2f1b2ed30dc5c20e7)
* `New-TssSession` updates to tests [dfe9d9b](https://github.com/thycotic-ps/thycotic.secretserver/commit/dfe9d9bc612421c777be5bd25d6f6abe26fe2ca3)
* `New-TssSession` updated tests to format date comparison for consistency [7b1e998](https://github.com/thycotic-ps/thycotic.secretserver/commit/7b1e998bfda6f10322b5567afc3a3d347c804930)

## [0.29.0] -- 2021-02-09

### Added

* `Set-TssSecret` **added** parameters: `AutoChangeEnabled`, `AutoChangeNextPassword` and `EnableInheritPermissions` [#12](https://github.com/thycotic-ps/thycotic.secretserver/issues/12) [a772b5b](https://github.com/thycotic-ps/thycotic.secretserver/commit/a772b5b8dd19d5249a9aa5d8f8a63700b39bec4e)

### Changed

* **Corrected** online link for `Remove-TssSecret`
* Reworked error handling in the module [#68](https://github.com/thycotic-ps/thycotic.secretserver/issues/68) [a53a50f](https://github.com/thycotic-ps/thycotic.secretserver/commit/a53a50f5749d2e65c37defae8243dd54fa76a317)
* `New-TssSession` - reworked logic and error handling in building the `TssSession` object [#69](https://github.com/thycotic-ps/thycotic.secretserver/issues/69) [9a983a3](https://github.com/thycotic-ps/thycotic.secretserver/commit/9a983a387fdd10b07dd8463acd272fa62b8f753e)

## [0.28.1] -- 2021-02-07

### Added

* None

### Changed

* Corrected LINK in function CBH [7cfc849](https://github.com/thycotic-ps/thycotic.secretserver/commit/7cfc8497b24f9b24b8d11412b9d42db394adabc4)

## [0.28.0] -- 2021-02-07

### Added

* `Search-TssFolder` [#10](https://github.com/thycotic-ps/thycotic.secretserver/issues/10) [cec6db9](https://github.com/thycotic-ps/thycotic.secretserver/commit/cec6db9545423cddf7fb9f02a123ba5f32a6f5b8)
* `Find-TssFolder` [#11](https://github.com/thycotic-ps/thycotic.secretserver/issues/11) [13f7802](https://github.com/thycotic-ps/thycotic.secretserver/commit/13f780266feae564b099e60df18278d23efdc2b0)
* `Get-TssFolderStub` [#63](https://github.com/thycotic-ps/thycotic.secretserver/issues/63) [9f535aa](https://github.com/thycotic-ps/thycotic.secretserver/commit/9f535aa341a046a5b73ffdeb5c64398fa27760e1) [06accc6](https://github.com/thycotic-ps/thycotic.secretserver/commit/06accc642faf825181665d05e123bfd3d050aef6)
* `New-TssFolder` [#65](https://github.com/thycotic-ps/thycotic.secretserver/issues/65) [06accc6](https://github.com/thycotic-ps/thycotic.secretserver/commit/06accc642faf825181665d05e123bfd3d050aef6)
* `Remove-TssFolder` [#66](https://github.com/thycotic-ps/thycotic.secretserver/issues/66) [81fdd6e](https://github.com/thycotic-ps/thycotic.secretserver/commit/81fdd6ef6cad84d0cbb35743bd748f57ba3d4e1d)
* Created `TssDelete` class to cover DeleteModel [e2eaee1](https://github.com/thycotic-ps/thycotic.secretserver/commit/e2eaee1a37e1f20f24235101e31878d6eb5901ff)

### Changed

* **Removed** `-Raw` parameter from all functions [1c74017](https://github.com/thycotic-ps/thycotic.secretserver/commit/1c74017b3ebe5b989f6caef34acad8e83294138b)
* **Renamed** `Disable-TssSecret` --> `Remove-TssSecret` [237ae47](https://github.com/thycotic-ps/thycotic.secretserver/commit/237ae473f760364b79bef102c306614b316680bf)
* Corrected output for `Get-TssFolder` [6aa9fa4](https://github.com/thycotic-ps/thycotic.secretserver/commit/6aa9fa434c9ae56c149aa3e4546309ad6cf3263f)
* **Output** changed to `TssDelete` for `Remove-TssReportCategory` [c5adf0f](https://github.com/thycotic-ps/thycotic.secretserver/commit/c5adf0f8968b0c17cea3dac3273eff19f784f3d5)

## [0.27.0] -- 2021-02-04

### Added

* `Get-TssSecretStub` [#27](https://github.com/thycotic-ps/thycotic.secretserver/issues/27) [5f87e28](https://github.com/thycotic-ps/thycotic.secretserver/commit/5f87e2832ef995729819239647746644dfcfb04a)
* `New-TssSecret` [#29](https://github.com/thycotic-ps/thycotic.secretserver/issues/29) [579a2b8](https://github.com/thycotic-ps/thycotic.secretserver/commit/579a2b8c8cfeca06d2bfb38a43acdaf9a8336321)
* `TssGroupSummary` about help file [3d15a8d](https://github.com/thycotic-ps/thycotic.secretserver/commit/3d15a8df92aaf05b72d452c10777f41822ab4780)

### Changed

* Renamed `Stop-TssPasswordChange` --> `Stop-TssSecretPasswordChange` [aebd59f](https://github.com/thycotic-ps/thycotic.secretserver/commit/aebd59fd56225a21351dff59216a322ed445d0c2)
* Renamed `Search-TssUserGroup` --> `Search-TssGroup` [aebd59f](https://github.com/thycotic-ps/thycotic.secretserver/commit/aebd59fd56225a21351dff59216a322ed445d0c2)

## [0.26.0] -- 2021-01-27

### Added

* GitHub Action for testing import on cross-platforms - [eb2e9bb](https://github.com/thycotic-ps/thycotic.secretserver/commit/eb2e9bb89e0b7b3019b3b97b0569faddecca7234)
* `Search-TssReportSchedule` [#47](https://github.com/thycotic-ps/thycotic.secretserver/issues/47) [ce1f9cc](https://github.com/thycotic-ps/thycotic.secretserver/commit/ce1f9cc798ce1e5c0f8df95e192dd5b116329cef)
* `Search-TssReportSchedule` SortBy param [ace866d](https://github.com/thycotic-ps/thycotic.secretserver/commit/ace866df8976565529af52235e7908a1c3974482)
* `Search-TssSecret` SortBy param [b64ea8b](https://github.com/thycotic-ps/thycotic.secretserver/commit/b64ea8baee1605788fc16207d615b426262b4038)
* `Search-TssUserGroup` new command [ba60175](https://github.com/thycotic-ps/thycotic.secretserver/commit/ba6017583db4bf4e76ac9c45b0280909b0fb914f)
* `Stop-TssPasswordChange` new command [#48](https://github.com/thycotic-ps/thycotic.secretserver/issues/48) [a47e3f1](https://github.com/thycotic-ps/thycotic.secretserver/commit/a47e3f1a3dbf62ec799336df6b0f84fac543a1b5)

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
