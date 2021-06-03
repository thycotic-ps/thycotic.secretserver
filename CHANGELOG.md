# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased] -- 2021-xx-xx

### Breaking Changes

<details>
    <summary>Click to view </summary>

* Protect-Secret - Renamed to Close-Secret Removed output as well. Will return no output if successful. [ab774f0](https://github.com/thycotic-ps/thycotic.secretserver/commit/ab774f089854722c0bece134b9454226f1b3c100)

</details>

### Bug Fixes

<details>
    <summary>Click to view </summary>

* module - fix issue with import on unix OS [c73537f](https://github.com/thycotic-ps/thycotic.secretserver/commit/c73537f9c8e879c73b78ae853f9f1859373a459a)
* Disable/Enable Unlimited Admin - correcting validation [2c32f8f](https://github.com/thycotic-ps/thycotic.secretserver/commit/2c32f8fab3fd7a62eb07d8c9b6919b516b8041d3)
* Search-SecretPermission - correct issue from test [3af9359](https://github.com/thycotic-ps/thycotic.secretserver/commit/3af93592fd550814103013adcdfb3c0d8fe742fb)
* Update-GroupMember - corrected error Functions as expected now [b9fda39](https://github.com/thycotic-ps/thycotic.secretserver/commit/b9fda39cd850ef49f295ad1766bcdbd6fb84e7a9)

</details>

### New Stuff

<details>
    <summary>Click to view </summary>

* Search-SecretPermission - closes [#186](https://github.com/thycotic-ps/thycotic.secretserver/issues/186) [7731fab](https://github.com/thycotic-ps/thycotic.secretserver/commit/7731fabecea4f4d8e2008bb12469d3b929fa8f81)
* Remove-SecretPermission - closes [#187](https://github.com/thycotic-ps/thycotic.secretserver/issues/187) [d020a14](https://github.com/thycotic-ps/thycotic.secretserver/commit/d020a14844cc558b4ff2cd32cd78f1add43fb76e)
* Update-SecretPermission - closes #189 [2cf1104](https://github.com/thycotic-ps/thycotic.secretserver/commit/2cf1104999b4762801c1282faf7e2e164ac26bb4)
* Search-SecretPolicy [b980a3d](https://github.com/thycotic-ps/thycotic.secretserver/commit/b980a3d7c47cade3820d09cd253054a5ba7c6dfa)
* Search-SecretHook - closes [#191](https://github.com/thycotic-ps/thycotic.secretserver/issues/191) [fb3a7ed](https://github.com/thycotic-ps/thycotic.secretserver/commit/fb3a7eded3da0f46bdc74756afff0f75e30e5e89)
* Open-Secret - allows for checking out a secret [dc23ab3](https://github.com/thycotic-ps/thycotic.secretserver/commit/dc23ab3ea48aaef7e3a91ff4e4cc3f06445ab4df)
* Get-SecretHook - closes [#192](https://github.com/thycotic-ps/thycotic.secretserver/issues/192) [87f6a6e](https://github.com/thycotic-ps/thycotic.secretserver/commit/87f6a6e1a89d8288184d6506ecd4ceb5d7fdccfb)
* Update-GroupMember - usage pending correction of endpoint There is a null exception being thrown in 10.9.64 for the endpoint. [b4f63b4](https://github.com/thycotic-ps/thycotic.secretserver/commit/b4f63b4b312602e8b1694f8120c703c84e4a64ef)
* Remove-SecretHook - closes [#193](https://github.com/thycotic-ps/thycotic.secretserver/issues/193) [8d2aa75](https://github.com/thycotic-ps/thycotic.secretserver/commit/8d2aa7537f2fe892f6a3924a4f5f91040680f666)
* Update-SecretHook - closes #194 [235ee5f](https://github.com/thycotic-ps/thycotic.secretserver/commit/235ee5f31ecd1b162ab11b3ef9032c2f2693928f)

</details>

### General Updates

<details>
    <summary>Click to view </summary>

* adding devcontainer [cfa85ad](https://github.com/thycotic-ps/thycotic.secretserver/commit/cfa85ad9fd59e7988beb8a1ce829f0ea7a8a73ca)
* module - Add aliases Checkout-Secret / CheckIn-Secret Compliments use of the Open/Close-Secret [5ee8224](https://github.com/thycotic-ps/thycotic.secretserver/commit/5ee822490fc08f506f5c6d2b7f61f04433c2e6fc)
* Module - implemented [Nullable[datetime]] Handles endpoints that return null for datetime properties [20a41e7](https://github.com/thycotic-ps/thycotic.secretserver/commit/20a41e7a079f28d7b6c60960797409c944686237)
* module - correct version check [458e56f](https://github.com/thycotic-ps/thycotic.secretserver/commit/458e56fc2f307e628321679d81823e6d0f903d38)
* Add-GroupMember - correct help info [1ffbb64](https://github.com/thycotic-ps/thycotic.secretserver/commit/1ffbb6496ab2db85255f638ccae59c3900758d0f)
* module - correcting variable reference [ce12ea8](https://github.com/thycotic-ps/thycotic.secretserver/commit/ce12ea87c778f726ed305f69572b86e1c20b4fc2)

</details>

### Tests

<details>
    <summary>Click to view </summary>

* None

</details>

## [0.40.0] -- 2021-05-28

### Breaking Changes

<details>
    <summary>Click to view </summary>

* None

</details>

### Bug Fixes

<details>
    <summary>Click to view </summary>

* TssUserSummary - add property TwoFactorMethod [880672b](https://github.com/thycotic-ps/thycotic.secretserver/commit/880672b71f3a7643cd2f17ef00bb11f5b54fe263)

</details>

### New Stuff

<details>
    <summary>Click to view </summary>

* Get-SecretDependencyTemplate [d28cf62](https://github.com/thycotic-ps/thycotic.secretserver/commit/d28cf623d5b47bd21af6ebcb84b0f7f9466f0ce7)
* Get-SecretDependencyStub [7a750fe](https://github.com/thycotic-ps/thycotic.secretserver/commit/7a750fe6cf3fbb162bb3a69ae163719ad3c7e7c2)
* Thycotic.Logging nested module added [77a0971](https://github.com/thycotic-ps/thycotic.secretserver/commit/77a09710612815caba533377d6975f5562a837f6)
* Find-Group - closes [#57](https://github.com/thycotic-ps/thycotic.secretserver/issues/57) [7fdb96b](https://github.com/thycotic-ps/thycotic.secretserver/commit/7fdb96b9ef9ed7bf4baa324cba8e717c7bc3f4b1)
* Get-Group - closes [#56](https://github.com/thycotic-ps/thycotic.secretserver/issues/56) [763f23b](https://github.com/thycotic-ps/thycotic.secretserver/commit/763f23b2a35ea35c9ce885a88a0b93ef4e0d6af5)
* Remove-GroupMember - closes [#52](https://github.com/thycotic-ps/thycotic.secretserver/issues/52) [b7d8494](https://github.com/thycotic-ps/thycotic.secretserver/commit/b7d8494391e3ca50aaff3f3dc2f72d23b64d4b46)
* Get-GroupRole - closes [#54](https://github.com/thycotic-ps/thycotic.secretserver/issues/54) [f4e3099](https://github.com/thycotic-ps/thycotic.secretserver/commit/f4e309958ab54daf706d4032a6b4c531cbb5e2f7)
* Get-GroupUser - closes [#53](https://github.com/thycotic-ps/thycotic.secretserver/issues/53) [f9cf8c2](https://github.com/thycotic-ps/thycotic.secretserver/commit/f9cf8c277c5ccb0dd26a959acfdb167cc167957c)
* Add-GroupMember - closes [#51](https://github.com/thycotic-ps/thycotic.secretserver/issues/51) [d57c131](https://github.com/thycotic-ps/thycotic.secretserver/commit/d57c13124f078d69c5e1c53d069b9f2db398aeef)
* Get-UserGroup - closes [#96](https://github.com/thycotic-ps/thycotic.secretserver/issues/96) [083c498](https://github.com/thycotic-ps/thycotic.secretserver/commit/083c49889bd08edd506299b2b7ee23fb3b5bd3bc)
* Get-UserOwner - closes [#95](https://github.com/thycotic-ps/thycotic.secretserver/issues/95) [9292857](https://github.com/thycotic-ps/thycotic.secretserver/commit/9292857fc177c6054e2eec0a72dc3cdda96169e7)
* Enable/Disable Unlimited Admin Mode [8b64a58](https://github.com/thycotic-ps/thycotic.secretserver/commit/8b64a58a1e16957e5bc2b8bc36892b4fbe461216)
* New-SecretPermission - closes #188 [eac25ad](https://github.com/thycotic-ps/thycotic.secretserver/commit/eac25ad87b37ab7043bcadc5ea0ae46f89107700)

</details>

### General Updates

<details>
    <summary>Click to view </summary>

* Search-SecretDependency - adjust output [c2aa919](https://github.com/thycotic-ps/thycotic.secretserver/commit/c2aa919f127f3998494aeec94ad016aac082d9af)
* Get-SecretDependencyTemplate - rename class type [855ab2e](https://github.com/thycotic-ps/thycotic.secretserver/commit/855ab2ee64ec5cfc3fc8b477cdba6b919d13657c)
* module - correct command alias reference and examples [95f4656](https://github.com/thycotic-ps/thycotic.secretserver/commit/95f46566dd37787d56281e50f369c0374452c6ea)
* module - correct links in manifest [a898187](https://github.com/thycotic-ps/thycotic.secretserver/commit/a89818717c4ea7ddbea2d436fff95afe72f7365d)
* Set-Secret - formatting [4795cf3](https://github.com/thycotic-ps/thycotic.secretserver/commit/4795cf36922213aeb69a72eb585070706ca037f3)
* Module - adjust how version check is performed This removes calling the version endpoint in every command, only called once now. [fb317ba](https://github.com/thycotic-ps/thycotic.secretserver/commit/fb317ba0a2aa697027535552a535e2e299a6f96c)
* module - applying formatting changes [71fa1f7](https://github.com/thycotic-ps/thycotic.secretserver/commit/71fa1f714dfbf8ce203d607f8d966921f775ef0e)
* Get-UserAudit - fixing warning message [99dd43e](https://github.com/thycotic-ps/thycotic.secretserver/commit/99dd43e3465888efe7feb3383e1d62cb93364aa5)

</details>

### Tests

<details>
    <summary>Click to view </summary>

* Tests - renaming [9cb0867](https://github.com/thycotic-ps/thycotic.secretserver/commit/9cb0867e456c2efcc20d6af8f279516d8374ca48)
* Tests - Removed integration and unit testing [ddc96c2](https://github.com/thycotic-ps/thycotic.secretserver/commit/ddc96c22efe387038bc3414875cd2e06f2109d3f)

</details>

## [0.39.0] -- 2021-05-07

### Breaking Changes

<details>
    <summary>Click to view </summary>

* None

</details>

### Bug Fixes

<details>
    <summary>Click to view </summary>

* None

</details>

### New Stuff

<details>
    <summary>Click to view </summary>

* Search-SecretDependency - fixes [#173](https://github.com/thycotic-ps/thycotic.secretserver/issues/173) [3ad064b](https://github.com/thycotic-ps/thycotic.secretserver/commit/3ad064b39b00b5d55a58164ff7c61144c9a43ee1)
* New-SecretDependencyGroup - fixes [#178](https://github.com/thycotic-ps/thycotic.secretserver/issues/178) [26a2c80](https://github.com/thycotic-ps/thycotic.secretserver/commit/26a2c80e10db2e3ce9e6569a47b81902b4fa8c58)
* Get-Secret - Add Path support fixes #174 [e3fcf0e](https://github.com/thycotic-ps/thycotic.secretserver/commit/e3fcf0e1f6b35a9f7c418a1be75212d1dbb317c1)
* Get-SecretDependency - fixes [#175](https://github.com/thycotic-ps/thycotic.secretserver/issues/175) [2be0039](https://github.com/thycotic-ps/thycotic.secretserver/commit/2be00397e07036d60225eaae5e32dc9a24758688)
* Get-SecretDependencyGroup - fixes [#177](https://github.com/thycotic-ps/thycotic.secretserver/issues/177) [e4740a5](https://github.com/thycotic-ps/thycotic.secretserver/commit/e4740a563b43e621549e3d348502e00a461d22c9)
* Remove-SecretDependency - closes #176 [c6173c8](https://github.com/thycotic-ps/thycotic.secretserver/commit/c6173c81f50d60bbcd0b936e8fa9adff0c4a089c)
* Set-SecretField - support files via value If content of file provided via value, include FileName [94f0654](https://github.com/thycotic-ps/thycotic.secretserver/commit/94f0654b4c8a26279be080a3d0b63e622114d062)
* Start-SecretDependency - fixes [#179](https://github.com/thycotic-ps/thycotic.secretserver/issues/179) [2565995](https://github.com/thycotic-ps/thycotic.secretserver/commit/25659956127826ef05db97e948dcaf4ec0caf559)
* Get-SecretDependencyRunStatus - fixes [#180](https://github.com/thycotic-ps/thycotic.secretserver/issues/180) [c062da2](https://github.com/thycotic-ps/thycotic.secretserver/commit/c062da298a7c30bdb3acf8a2305f51033bbbddee)

</details>

### General Updates

<details>
    <summary>Click to view </summary>

* module - add format for dependency classes [51ae103](https://github.com/thycotic-ps/thycotic.secretserver/commit/51ae10387ef6d2d0e9add56f05ede7ccfd7c0288)
* Get-SecretDependency - adding param description [bf97d39](https://github.com/thycotic-ps/thycotic.secretserver/commit/bf97d39e883c9702e7bbfb2e0440cb21f070707f)
* Start-SecretHeartbeat - correcting help links [e4d9c95](https://github.com/thycotic-ps/thycotic.secretserver/commit/e4d9c95a82fc0d168ba28d80e3c7539949162ae4)

</details>

### Tests

<details>
    <summary>Click to view </summary>

* None

</details>

## [0.38.0] -- 2021-04-28

### Breaking Changes

<details>
    <summary>Click to view </summary>

* None

</details>

### Bug Fixes

<details>
    <summary>Click to view </summary>

* New-TssUser - add examples fixes [#160](https://github.com/thycotic-ps/thycotic.secretserver/issues/160) [400ac84](https://github.com/thycotic-ps/thycotic.secretserver/commit/400ac84cfc307b63e0f4e412c5d52a8878031172)
* Update-TssSecret - fix issue with uri found during testing [b7e96f1](https://github.com/thycotic-ps/thycotic.secretserver/commit/b7e96f17e897d102ef2cb01ea9fb63c7caaf4f68)
* Docs - correcting links for CBH [8347663](https://github.com/thycotic-ps/thycotic.secretserver/commit/834766305ae6c82de43c11a1008286e098647cba)

</details>

### New Functions

<details>
    <summary>Click to view </summary>

* Update-TssSecret - fixes [#169](https://github.com/thycotic-ps/thycotic.secretserver/issues/169) [3587c61](https://github.com/thycotic-ps/thycotic.secretserver/commit/3587c61b2f991da8fc518d33cfeca0c20dfb5437)
* Search-TssRpcPasswordType - closes [#149](https://github.com/thycotic-ps/thycotic.secretserver/issues/149) [5f99639](https://github.com/thycotic-ps/thycotic.secretserver/commit/5f996396084919fb68417fc27df664d60fc6d8ff)
* Get-RpcPasswordType - closes [#34](https://github.com/thycotic-ps/thycotic.secretserver/issues/34) [dacde70](https://github.com/thycotic-ps/thycotic.secretserver/commit/dacde70e070c998e83a7461b864450298676635e)
* Get-GroupMember - closes [#55](https://github.com/thycotic-ps/thycotic.secretserver/issues/55) [66a203d](https://github.com/thycotic-ps/thycotic.secretserver/commit/66a203d8d46be56059890e9e0d2eba978b7e13f8)
* Secret Template - Added New-SecretTemplateField and Add-SecretTemplateField [7fdd18b](https://github.com/thycotic-ps/thycotic.secretserver/commit/7fdd18bab2fc68b2e4793db8b56ebbc487da1fb6)

</details>

### General Updates

<details>
    <summary>Click to view </summary>

* docs - commands page - remove links to spec file New API doc site: https://thycotic-ps.github.io/secretserver-apidoc [3f16fee](https://github.com/thycotic-ps/thycotic.secretserver/commit/3f16fee904af3b2eb13312c8564967a09a6e2a23)
* Set-SecretField - Correcting examples [6f89ba2](https://github.com/thycotic-ps/thycotic.secretserver/commit/6f89ba298f3f8efe2a391a245307cbc5a83c593b)

</details>

### Tests

<details>
    <summary>Click to view </summary>

* None

</details>

## [0.37.0] -- 2021-04-16

### Breaking Changes

<details>
    <summary>Click to view </summary>

* Removed Folder and User stub commands [c5037c4](https://github.com/thycotic-ps/thycotic.secretserver/commit/c5037c449325c205f64b76c3348d523fc7af6c03)

</details>

### Bug Fixes

<details>
    <summary>Click to view </summary>

* None

</details>

### New

<details>
    <summary>Click to view </summary>

* Get-TssFolder - Add FolderPath parameter [05dd198](https://github.com/thycotic-ps/thycotic.secretserver/commit/05dd198a5470d2e3d157879c50294dfac0ce07aa)
* New-TssUser - closes [#127](https://github.com/thycotic-ps/thycotic.secretserver/issues/127) [27b69a7](https://github.com/thycotic-ps/thycotic.secretserver/commit/27b69a7a3c86ae6d5572539ccce815d380206f65)
* Get-TssSecretRpcAssociated - closes [#154](https://github.com/thycotic-ps/thycotic.secretserver/issues/154) [5bb28d0](https://github.com/thycotic-ps/thycotic.secretserver/commit/5bb28d079665d890d83ace9b6aa381bf5594a7e5)
* Update-UserPassword - closes [#155](https://github.com/thycotic-ps/thycotic.secretserver/issues/155) [cd6dc87](https://github.com/thycotic-ps/thycotic.secretserver/commit/cd6dc87ef76759cddadd06442f2066d793c91320)
* Set-SecretRpcAssociated - closes #153 [1da9eab](https://github.com/thycotic-ps/thycotic.secretserver/commit/1da9eab708b4da09c085c580eb94722ff87e7521)
* Reset-UserPassword - fixes [#129](https://github.com/thycotic-ps/thycotic.secretserver/issues/129) [315c28d](https://github.com/thycotic-ps/thycotic.secretserver/commit/315c28d9bd578854db9eea015c24e08d3027a858)
* Unlock-User - closes [#159](https://github.com/thycotic-ps/thycotic.secretserver/issues/159) [5cf2157](https://github.com/thycotic-ps/thycotic.secretserver/commit/5cf2157f3335e05d507d5b5eb075ea85c5f90c15)
* Lock-User - closes [#158](https://github.com/thycotic-ps/thycotic.secretserver/issues/158) [b76de38](https://github.com/thycotic-ps/thycotic.secretserver/commit/b76de38d756a5e97276727dd52714250ae66bf0a)
* Enable-TssUser - closes [#156](https://github.com/thycotic-ps/thycotic.secretserver/issues/156) [b9fa4bd](https://github.com/thycotic-ps/thycotic.secretserver/commit/b9fa4bd3975884cd63b31b0503688fe5870086e6)
* Disable-User - closes [#157](https://github.com/thycotic-ps/thycotic.secretserver/issues/157) [51fedf8](https://github.com/thycotic-ps/thycotic.secretserver/commit/51fedf88c8988383f08ecdde73a51d36354d9f60)
* Start-Discovery - closes [#151](https://github.com/thycotic-ps/thycotic.secretserver/issues/151) [05501de](https://github.com/thycotic-ps/thycotic.secretserver/commit/05501de057970265229ab49e99a8ae63035c7c14)

</details>

### General Updates

<details>
    <summary>Click to view </summary>

* Search-TssFolder - perf improvement [233744d](https://github.com/thycotic-ps/thycotic.secretserver/commit/233744d745179a3da8c2ce47866dcc40bdecd9f6)
* docs - add New-TssUser help [738584d](https://github.com/thycotic-ps/thycotic.secretserver/commit/738584d38b8077d0606b4e61028899e72b0ebe73)
* docs - removed command old command help [371d137](https://github.com/thycotic-ps/thycotic.secretserver/commit/371d137f96c50adfaf0251b278f8382ddc49dcab)
* Get-SecretRpcAssociated - adjust output to support Set function [e6e3523](https://github.com/thycotic-ps/thycotic.secretserver/commit/e6e3523c93625819c37f48a5ab1b3a0c96442611)
* Protect-Secret - remove unused code [2922f21](https://github.com/thycotic-ps/thycotic.secretserver/commit/2922f211fb668f3729c3b587c98db1f6399dead0)
* Enable-SecretEmail - correct link in cbh [4ded087](https://github.com/thycotic-ps/thycotic.secretserver/commit/4ded087c6b5b2cd8da771fae4ef1210af7b9b0f4)
* functions - correcting parameter help [a1fc3df](https://github.com/thycotic-ps/thycotic.secretserver/commit/a1fc3dfedc2b0d04da96cf252a8cc7710eb1a8f9)

</details>

### Tests

<details>
    <summary>Click to view </summary>

* None

</details>

## [0.36.0] -- 2021-04-05

### Breaking Changes

<details>
    <summary>Click to view </summary>

* None

</details>

### Bug Fixes

<details>
    <summary>Click to view </summary>

* New-TssFolder - fixes [#145](https://github.com/thycotic-ps/thycotic.secretserver/issues/145) [ba94c17](https://github.com/thycotic-ps/thycotic.secretserver/commit/ba94c17255c9494999e2d55998e31d5289df2489)
* docs - Working With content [#82](https://github.com/thycotic-ps/thycotic.secretserver/issues/82) [650ae1e](https://github.com/thycotic-ps/thycotic.secretserver/commit/650ae1e39c3bf26883307e216ef1362c2e6272a5)
* Set-TssSecret - fixes [#147](https://github.com/thycotic-ps/thycotic.secretserver/issues/147) [a9dd25f](https://github.com/thycotic-ps/thycotic.secretserver/commit/a9dd25f2d87ff0138692ab2dee018d7e8c6e33ae)
* Get-TssConfiguration - fixes [#148](https://github.com/thycotic-ps/thycotic.secretserver/issues/148) April release adds additional properties [8c5d6a8](https://github.com/thycotic-ps/thycotic.secretserver/commit/8c5d6a8d5c9ec94ee64af3f1fcd18f9ae6cfe568)

</details>

### New Functions

<details>
    <summary>Click to view </summary>

* Revoke-Secret - fixes [#134](https://github.com/thycotic-ps/thycotic.secretserver/issues/134) [64d14e2](https://github.com/thycotic-ps/thycotic.secretserver/commit/64d14e223a687275b5e886a48ceeefd610fb05fa)
* Start-SecretHeartbeat - fixes [#135](https://github.com/thycotic-ps/thycotic.secretserver/issues/135) [34dfd79](https://github.com/thycotic-ps/thycotic.secretserver/commit/34dfd79af17c8e210787ab2737e7eb6f7c0e7693)
* Set-SecretExpiration - fixes [#136](https://github.com/thycotic-ps/thycotic.secretserver/issues/136) [48db3bc](https://github.com/thycotic-ps/thycotic.secretserver/commit/48db3bc35dee031ce098e41dbad04df976379c32)
* Set-SecretRpcPrivileged - fixes [#139](https://github.com/thycotic-ps/thycotic.secretserver/issues/139) [91a4851](https://github.com/thycotic-ps/thycotic.secretserver/commit/91a485165a40bc662cca70d779d8d04479f06247)
* Search-DistributedEngineSite - fixes [#146](https://github.com/thycotic-ps/thycotic.secretserver/issues/146) [c9165c9](https://github.com/thycotic-ps/thycotic.secretserver/commit/c9165c9c6ac2f17720cf5735681884848899216a)

</details>

### General Updates

<details>
    <summary>Click to view </summary>

* Set-SecretExpiration - update variable name [941b21c](https://github.com/thycotic-ps/thycotic.secretserver/commit/941b21c14d0453624dcc7812d64bc169ebad5344)

</details>

### Tests

<details>
    <summary>Click to view </summary>

* Tests - added assert calls [4dbe545](https://github.com/thycotic-ps/thycotic.secretserver/commit/4dbe5455fbcdfb92ecb5b92d2b893ed52fc3d147)

</details>

## [0.35.0] -- 2021-04-04

### Breaking Changes

<details>
    <summary>Click to view </summary>

* TssSecret - GetCredential method update closes [#133](https://github.com/thycotic-ps/thycotic.secretserver/issues/133) [92e8a1e](https://github.com/thycotic-ps/thycotic.secretserver/commit/92e8a1ed56c9b4fb730bef16286ec32551632808)
* New-TssFolder - Revert param changes [78638ed](https://github.com/thycotic-ps/thycotic.secretserver/commit/78638ed6b0ea05af977f99ba8caa65ce86eecc07)

</details>

### Bug Fixes

<details>
    <summary>Click to view </summary>

* module - correct import closes [#132](https://github.com/thycotic-ps/thycotic.secretserver/issues/132) [47ec7ce](https://github.com/thycotic-ps/thycotic.secretserver/commit/47ec7cebc86dc6be4594d7395b88198c37f973fc)
* Find-User - fixed output issue identified by test [3bee92b](https://github.com/thycotic-ps/thycotic.secretserver/commit/3bee92bfdd93be5d4ce4171247603b4933bd719b)
* CheckVersion - correct invoke param [57dfb6d](https://github.com/thycotic-ps/thycotic.secretserver/commit/57dfb6d03b1b450c874aa18ec7e913e7f77c3dad)
* Set-TssSecret - fixing bug identified during testing Removing Template param as this is not usable on the endpoint [9fc876b](https://github.com/thycotic-ps/thycotic.secretserver/commit/9fc876bc2beed32cf14fa7b1501c50f9dd65984f)
* CheckVersion - correct invoke param [57dfb6d](https://github.com/thycotic-ps/thycotic.secretserver/commit/57dfb6d03b1b450c874aa18ec7e913e7f77c3dad)
* TssSession - Correct issue found on SessionRefresh [83d6533](https://github.com/thycotic-ps/thycotic.secretserver/commit/83d65333a248154194dda25ab85743ece0aeb77c)

</details>

### New Functions

<details>
    <summary>Click to view </summary>

* Get-TssUserStub - closes #97 [5650be7](https://github.com/thycotic-ps/thycotic.secretserver/commit/5650be73b21ce742d0a7e00d59bec4838462b3f8)
* Set-TssSecretSecurity - fixes #137 [9e3b22e](https://github.com/thycotic-ps/thycotic.secretserver/commit/9e3b22e331bec9a967782b86147173d21c8e0b78)

</details>

### General Updates

<details>
    <summary>Click to view </summary>

* build - remove outputing file list [87929d6](https://github.com/thycotic-ps/thycotic.secretserver/commit/87929d6659551091bbfd7bfa9ffdf9f781e8d38c)
* Get-UserStub - moving to correct directory [2a23010](https://github.com/thycotic-ps/thycotic.secretserver/commit/2a23010dcacc8b8f1490a0d164f7686783e989ac)
* module - change API call method to internal script [92f32e0](https://github.com/thycotic-ps/thycotic.secretserver/commit/92f32e09707578264a771ff2c44b5e2df412409b)
* module - CheckVersion correct logic, remove function call [a4799d8](https://github.com/thycotic-ps/thycotic.secretserver/commit/a4799d841b861fa72c6d3edf4bea65721e712b6d)
* docs - TssSecret class updates [eef7af7](https://github.com/thycotic-ps/thycotic.secretserver/commit/eef7af7dfe761af9afe95101a86975c71121b1a9)
* Get-Secret - update examples [2cd81d8](https://github.com/thycotic-ps/thycotic.secretserver/commit/2cd81d89a5d1acc6853decc044d631b694dc3f4b)
* Get-UserRole - renamed parameter alias [1c482f5](https://github.com/thycotic-ps/thycotic.secretserver/commit/1c482f59e1360583237a5408f5722ce347768784)
* Stop-SecretChangePassword - remove Status property from output [97e9b78](https://github.com/thycotic-ps/thycotic.secretserver/commit/97e9b7866bdfbc82b24df39c13b3e5c5934ca111)
* docs - remove SDK setup section No longer applies [62ff8c6](https://github.com/thycotic-ps/thycotic.secretserver/commit/62ff8c6650e8af44fc0375e1a1d71b8ddc367d5e)
* Secret functions - corrected paramet set reference [bc849aa](https://github.com/thycotic-ps/thycotic.secretserver/commit/bc849aaddea2ccf9bec8eb77981009935b736dfc)
* Set-Secret - removed call to public function [dab8048](https://github.com/thycotic-ps/thycotic.secretserver/commit/dab80486d9ce68ec90d2750222e391c42e7c3527)
* Get-TssConfiguration - add about files for classes [42da615](https://github.com/thycotic-ps/thycotic.secretserver/commit/42da615c0a87096a16b34638044175086cf77bf6)
* doc - update commands [4a11a5d](https://github.com/thycotic-ps/thycotic.secretserver/commit/4a11a5d3da1dddad3476a1fc36521a0f25c33de1)
* module - applying formatting changes [71fa1f7](https://github.com/thycotic-ps/thycotic.secretserver/commit/71fa1f714dfbf8ce203d607f8d966921f775ef0e)

</details>

### Tests

<details>
    <summary>Click to view </summary>

* snippet - test added assert call [18685b6](https://github.com/thycotic-ps/thycotic.secretserver/commit/18685b6dbafd1ff7705e9c8a2719a04e19dda5c9)
* tests - add random string generator [8e1500d](https://github.com/thycotic-ps/thycotic.secretserver/commit/8e1500da6bdaf666ffc7555ada38a92e6107bb2e)
* Tests - Users tests reworked [738098f](https://github.com/thycotic-ps/thycotic.secretserver/commit/738098f5a24753dd458ae754b5c7a58d1a533cec)
* tests - removed test data (no longer needed) [f68c137](https://github.com/thycotic-ps/thycotic.secretserver/commit/f68c137e95be82807f526720c3d309301667ab6e)
* Secret Tests - reworked [ee188be](https://github.com/thycotic-ps/thycotic.secretserver/commit/ee188beab18438a64cb46e5f98ef2356341c6546)
* Set-Secret - Tests rework Still work to do [cb39262](https://github.com/thycotic-ps/thycotic.secretserver/commit/cb39262473c730c9a6b4debc4560a1a60553ecb1)

</details>

## [0.34.0] -- 2021-03-25

### Breaking Changes

<details>
    <summary>Click to view </summary>

* Set-TssSecret - remove email setting params closes [#125](https://github.com/thycotic-ps/thycotic.secretserver/issues/125) [6e98382](https://github.com/thycotic-ps/thycotic.secretserver/commit/6e9838232eae4ce68de5e576e1db2601393d72fc)
* Set-TssSecret - remove field params closes [#118](https://github.com/thycotic-ps/thycotic.secretserver/issues/118) [8a90145](https://github.com/thycotic-ps/thycotic.secretserver/commit/8a901450880a0acc93cb7142d2f57eb50c4cdabb)
* Get-TssFolderPermissionStub - removed function [0194279](https://github.com/thycotic-ps/thycotic.secretserver/commit/01942795ddb43f6464d8265742fc2933de2347eb)

</details>

### New Functions

<details>
    <summary>Click to view </summary>

* Get-TssConfiguration - closes [#112](https://github.com/thycotic-ps/thycotic.secretserver/issues/112) [02555a6](https://github.com/thycotic-ps/thycotic.secretserver/commit/02555a6dfc42211997c3f2da966060a3205c44ab)
* Get-TssSecretSetting - closes [#15](https://github.com/thycotic-ps/thycotic.secretserver/issues/15) [d73252f](https://github.com/thycotic-ps/thycotic.secretserver/commit/d73252f010380a92e0cdb775061728f53942bd31)
* Get-TssSecretSummary - closes [#110](https://github.com/thycotic-ps/thycotic.secretserver/issues/110) [28e71d5](https://github.com/thycotic-ps/thycotic.secretserver/commit/28e71d58786d39f5bdd99ba2088b1e2bde1be785)
* Restore-TssSecret - closes [#123](https://github.com/thycotic-ps/thycotic.secretserver/issues/123) [6e73fa1](https://github.com/thycotic-ps/thycotic.secretserver/commit/6e73fa12c67d131c0d2bc96a4ec0d92a9162b7f7)
* Get-TssSecretPasswordStatus - added internal endpoint verbose [3755224](https://github.com/thycotic-ps/thycotic.secretserver/commit/37552242892275e9cfe6462850f7e4aa892d838c)
* Get-TssSecretHeartbeatStatus - closes [#121](https://github.com/thycotic-ps/thycotic.secretserver/issues/121) [9e35d28](https://github.com/thycotic-ps/thycotic.secretserver/commit/9e35d28a6e8b490e37257dfc0579043f42d8834c)
* Enable-TssSecretEmail - closes [#115](https://github.com/thycotic-ps/thycotic.secretserver/issues/115) [073d1b2](https://github.com/thycotic-ps/thycotic.secretserver/commit/073d1b2d1d1cc6bfc9e27840d0c58d7ce3013d6b)
* Disable-TssSecretEmail - closes [#120](https://github.com/thycotic-ps/thycotic.secretserver/issues/120) [1d944cf](https://github.com/thycotic-ps/thycotic.secretserver/commit/1d944cf53e61be4760d97a496f2ca7ed35fd6bc7)
* Enable-TssSecretCheckout - closes [#107](https://github.com/thycotic-ps/thycotic.secretserver/issues/107) [2c31bd9](https://github.com/thycotic-ps/thycotic.secretserver/commit/2c31bd9bd9d5df23f7d5c21acf4bf209325bf4f9)
* Disable-TssSecretCheckout - closes [#119](https://github.com/thycotic-ps/thycotic.secretserver/issues/119) [0d74290](https://github.com/thycotic-ps/thycotic.secretserver/commit/0d742907924a30bee933f4d1309dd0f7995f941b)
* Get-TssUserAudit - closes [#93](https://github.com/thycotic-ps/thycotic.secretserver/issues/93) [d436f65](https://github.com/thycotic-ps/thycotic.secretserver/commit/d436f65f951d06a7d3ba18ee7cc3bf169f2e0046)
* Set-TssSecretField - closes [#117](https://github.com/thycotic-ps/thycotic.secretserver/issues/117) [9ed4091](https://github.com/thycotic-ps/thycotic.secretserver/commit/9ed4091402844859607b48c23e8057788e224f5e)
* Search-TssSecretTemplate - closes [#81](https://github.com/thycotic-ps/thycotic.secretserver/issues/81) [f96c4bf](https://github.com/thycotic-ps/thycotic.secretserver/commit/f96c4bf2b661dc2adb5e1fa5968e3dcdb67c255c)
* Protect-TssSecret - closes [#131](https://github.com/thycotic-ps/thycotic.secretserver/issues/131) [cb8e53d](https://github.com/thycotic-ps/thycotic.secretserver/commit/cb8e53dc98682bcdb84a2631cc52f31f46582fb8)

</details>

### General Updates

<details>
    <summary>Click to view </summary>

* Search-TssGroup - code cleanup [1c796b8](https://github.com/thycotic-ps/thycotic.secretserver/commit/1c796b8b4fcde6dfa29d98f720d1720156f7de03)
* Search-TssRole - code cleanup [7f036f8](https://github.com/thycotic-ps/thycotic.secretserver/commit/7f036f8b64e268373575ca1f48b2a084733f2d9f)
* User Functions - code cleanup [f713a10](https://github.com/thycotic-ps/thycotic.secretserver/commit/f713a10bb8c278bbcf9bdd94356fcdf4e702c2c9)
* Report Functions - code cleanup [c40d571](https://github.com/thycotic-ps/thycotic.secretserver/commit/c40d57170cccab3495459534587948e7d748d32c)
* Get-TssSecretTemplate - code cleanup [cd6d21c](https://github.com/thycotic-ps/thycotic.secretserver/commit/cd6d21c76548463c4af97605a1c9972ff994af7e)
* Secret Functions - code cleanup [a8b63bf](https://github.com/thycotic-ps/thycotic.secretserver/commit/a8b63bf009ed1f20fb592edcbfd3d56ef01e9418)
* github action - updated branch reference [04a2aae](https://github.com/thycotic-ps/thycotic.secretserver/commit/04a2aae5583e093203c19f37e2152e5ca1d2b103)
* Module - file tests - exclude class files [6f983be](https://github.com/thycotic-ps/thycotic.secretserver/commit/6f983be8c1449f53c4010ab4c65b25a53494619a)
* Folder Functions - code cleanup [b98dc96](https://github.com/thycotic-ps/thycotic.secretserver/commit/b98dc963950bab659309aea9ac75d110fec97fba)
* Get-TssConfiguration - code cleanup [dc88291](https://github.com/thycotic-ps/thycotic.secretserver/commit/dc882911c9bbe3c71b4b554a233558b8b8df3e80)
* Search-TssDirectoryServiceDomain - code cleanup [2ec5ece](https://github.com/thycotic-ps/thycotic.secretserver/commit/2ec5ecead9e16859d144ec473f73da08bcfc651d)
* Folder Permission functions - code cleanup [0194279](https://github.com/thycotic-ps/thycotic.secretserver/commit/01942795ddb43f6464d8265742fc2933de2347eb)
* parts - simplify code for class objects [04f03fa](https://github.com/thycotic-ps/thycotic.secretserver/commit/04f03fa0f6aa4726f3a7215b59cfbb77373e9946)
* removing unnecessary code [a691b34](https://github.com/thycotic-ps/thycotic.secretserver/commit/a691b34f3f7855747cd3e48f51458a86c8456ac1)
* classes - import process adjustments for classes [8c8328e](https://github.com/thycotic-ps/thycotic.secretserver/commit/8c8328e1a4034d644dc269a1a14cbfe66a7a9de1)
* class - reformat and add properties to about topics [e1618b6](https://github.com/thycotic-ps/thycotic.secretserver/commit/e1618b626f7ecb5689d116f49c92083b35cf95f4)
* TssUserLookup - correct about file name [4138f18](https://github.com/thycotic-ps/thycotic.secretserver/commit/4138f1800669f417d8452dca66a053cf935bef11)
* vs code snippet - update tests [50ec291](https://github.com/thycotic-ps/thycotic.secretserver/commit/50ec291ad7364e8691a3efb6bd6515265bb5d165)
* Set-TssSecret - parameter update (help, alias) [5bebc09](https://github.com/thycotic-ps/thycotic.secretserver/commit/5bebc093e36d7b2f50f20c5ad523cab1db7d276a)
* Code Cleanup - removing use of ToString() [db3bf67](https://github.com/thycotic-ps/thycotic.secretserver/commit/db3bf67de155da44e944c7e43f519d8505ef6f3d)
* Search-TssSecret - output correction [3708042](https://github.com/thycotic-ps/thycotic.secretserver/commit/3708042a141be42e02b7beb47f81866e5f59b196)
* Snippet - adding tssapi for a generic oauth2 token and API call [7e0e0f5](https://github.com/thycotic-ps/thycotic.secretserver/commit/7e0e0f5d1ae99885d4069860291961d4190bbfae)
* Secret Email - Correct examples [9758aa8](https://github.com/thycotic-ps/thycotic.secretserver/commit/9758aa8a4cbf8807db619a71c514013d308bd732)
* Enable-TssSecretEmail - added restricted params [3436c86](https://github.com/thycotic-ps/thycotic.secretserver/commit/3436c86c97c393a102f2d663b5c9ec840d2dd4c4)
* Disable-TssSecretEmail - added restricted params [be6dbe9](https://github.com/thycotic-ps/thycotic.secretserver/commit/be6dbe91afa45f625ea4f1312bbaa5457d80fa47)
* module - example updates [fac30c3](https://github.com/thycotic-ps/thycotic.secretserver/commit/fac30c399323a110b047075309d5141275f16c8b)
* module - about files added [1b07f60](https://github.com/thycotic-ps/thycotic.secretserver/commit/1b07f60ab6ee6257176f6685c037236989fd720f)
* module - help adding source code link [67e06e3](https://github.com/thycotic-ps/thycotic.secretserver/commit/67e06e3def1da78daa0482649e7dc28b7596f83b)
* module - adjust TssSecretState format [da1f699](https://github.com/thycotic-ps/thycotic.secretserver/commit/da1f6991242e8707285c2afe8f39b9bef69de02e)
* module - adjusting pattern for restricted params [1ea709b](https://github.com/thycotic-ps/thycotic.secretserver/commit/1ea709bba013e5d0bd4d706b8aee0e45036c3a64)

</details>

### Bug Fixes

<details>
    <summary>Click to view </summary>

* Find-TssSecret - closes #111 [4f9d2c7](https://github.com/thycotic-ps/thycotic.secretserver/commit/4f9d2c7be971dcb1506cc569832712ef4e513336)
* TssSecret - SetFieldValue - closes [#124](https://github.com/thycotic-ps/thycotic.secretserver/issues/124) [aa75be9](https://github.com/thycotic-ps/thycotic.secretserver/commit/aa75be996d863c3d2c498ba38fd8cee704d4b8e9)
* Invoke-TssRestApi - correct issue with processing [1688c7d](https://github.com/thycotic-ps/thycotic.secretserver/commit/1688c7d25a68e5c1a6896c36c0961775b41127f4)

</details>

### Tests

<details>
    <summary>Click to view </summary>

* Folder Permission - Tests - update mocking [457fe7d](https://github.com/thycotic-ps/thycotic.secretserver/commit/457fe7ddd3c25756ffecd2190f02e0bd736852cf)
* New-TssFolderPermission Test - remove unused code [09981c8](https://github.com/thycotic-ps/thycotic.secretserver/commit/09981c88d775ef199d506295a2f10447db60a0a7)
* New-TssFolder - removed integration test ToDo - replace with mocking [3ac59d8](https://github.com/thycotic-ps/thycotic.secretserver/commit/3ac59d8574a1f17d6612b86431d94123e7eb2aef)

</details>

## [0.33.1] -- 2021-03-05

### Added

* None

### Changed

* `New-TssSession` adjust logic on URL for OAuth2 request [#109](https://github.com/thycotic-ps/thycotic.secretserver/issues/109) [f4061e5](https://github.com/thycotic-ps/thycotic.secretserver/commit/f4061e57906e127465f1c949e51eaec77da527a4)

## [0.33.0] -- 2021-03-05

### Added

<details>
    <summary>Click to view </summary>

* **Module** Added warning message on detected Secret Server version [more details](https://thycotic-ps.github.io/thycotic.secretserver/docs/compatibility/) [a97a8c5](https://github.com/thycotic-ps/thycotic.secretserver/commit/a97a8c5f880c5f2ae7a760af8843daa2e7967ccf)
* `Search-TssRole` **New Command** [#105](https://github.com/thycotic-ps/thycotic.secretserver/issues/105) [baca549](https://github.com/thycotic-ps/thycotic.secretserver/commit/baca54911d176565ee3fbd97d31dfbd4b15c3323)
* `Get-TssUserRoleAssigned` **New Command** [#92](https://github.com/thycotic-ps/thycotic.secretserver/issues/92) [5868714](https://github.com/thycotic-ps/thycotic.secretserver/commit/5868714be05ef4d661ba07d68170b7375ae2aea9)
* `Search-TssSecret` additional examples [5c1fc4b](https://github.com/thycotic-ps/thycotic.secretserver/commit/5c1fc4bfb123cb23a7dc50e3899a2bd4a804d936)
* `New-TssFolderPermission` added example [84f234c](https://github.com/thycotic-ps/thycotic.secretserver/commit/84f234ca3dc72312c849041fc0cb3304bc8fb72f)
* `Start-TssSecretChangePassword` **New Command** [#71](https://github.com/thycotic-ps/thycotic.secretserver/issues/71) [3f4e6a9](https://github.com/thycotic-ps/thycotic.secretserver/commit/3f4e6a9bcb33005ccef205072132479ad9bdb56e)
* `Get-TssSecretPasswordStatus` **New Command** [#71](https://github.com/thycotic-ps/thycotic.secretserver/issues/71) [3f4e6a9](https://github.com/thycotic-ps/thycotic.secretserver/commit/3f4e6a9bcb33005ccef205072132479ad9bdb56e)
* `Invoke-TssSecretGeneratePassword` **New Command** [#106](https://github.com/thycotic-ps/thycotic.secretserver/issues/106) [b3c4ad7](https://github.com/thycotic-ps/thycotic.secretserver/commit/b3c4ad782627ce0d43da6cd5618f8367947fe20a)
* `Search-TssUser` **New Command** [#99](https://github.com/thycotic-ps/thycotic.secretserver/issues/99) [173bd41](https://github.com/thycotic-ps/thycotic.secretserver/commit/173bd417441e11fa362053589113cf8133483275)
* `Search-TssDirectoryServiceDomain` **New Command** [ccb93f4](https://github.com/thycotic-ps/thycotic.secretserver/commit/ccb93f472d9317ca416ee20d71d5a326e5351a75)
* `Find-TssUser` **New Command** [#98](https://github.com/thycotic-ps/thycotic.secretserver/issues/98) [195b34a](https://github.com/thycotic-ps/thycotic.secretserver/commit/195b34af77b61483fc5cbc49639242bedbd67fe4)
* `Show-TssCurrentUser` **New Command** [#100](https://github.com/thycotic-ps/thycotic.secretserver/issues/100) [40f40c9](https://github.com/thycotic-ps/thycotic.secretserver/commit/40f40c9ef61045b50ebc1ca97b1d0130a5c8b2f6)
* `Get-TssUser` **New Command** [#101](https://github.com/thycotic-ps/thycotic.secretserver/issues/101) [9fa3a0b](https://github.com/thycotic-ps/thycotic.secretserver/commit/9fa3a0b41f5b75136b8dc65c87e6642f8a5d9db6)
* `Get-TssSecretAudit` **New Command** [#13](https://github.com/thycotic-ps/thycotic.secretserver/issues/13) [af9e621](https://github.com/thycotic-ps/thycotic.secretserver/commit/af9e621ebb76bc593d286b848a0a92d04efd6f19)
* `Get-TssSecretState` **New Command** [#17](https://github.com/thycotic-ps/thycotic.secretserver/issues/17) [357df13](https://github.com/thycotic-ps/thycotic.secretserver/commit/357df13fba08bd3db472d06f9ed06fd77f7dd9ac)
* `Get-TssSecretAttachment` **New Command** [#44](https://github.com/thycotic-ps/thycotic.secretserver/issues/44) [47a7b45](https://github.com/thycotic-ps/thycotic.secretserver/commit/47a7b45384b2b1bdd0fb01d35cb225ffd7ec627f)

</details>

### Changed

* `Set-TssSecret` - renamed `Folder` to be alias of `FolderId` [a1b56dc](https://github.com/thycotic-ps/thycotic.secretserver/commit/a1b56dca5f3bb670f2840b22711e8cb2ed9e4ef8)
* `Search-TssReportSchedule` - cleaning up output [2839f3a](https://github.com/thycotic-ps/thycotic.secretserver/commit/2839f3a9faad918987b71f24b01725d9792569f3)
* `Search-TssSecret` **breaking** - Renamed `FieldText` to `SearchText` with alias `SecretName` [#102](https://github.com/thycotic-ps/thycotic.secretserver/issues/102) [5c1fc4b](https://github.com/thycotic-ps/thycotic.secretserver/commit/5c1fc4bfb123cb23a7dc50e3899a2bd4a804d936)

## [0.32.0] -- 2021-02-28

### Added

* `Set-TssSecret` additional parameters: `CheckIn', 'ForceCheckIn', 'TicketNumber', TicketSystemId' [73c96b9](https://github.com/thycotic-ps/thycotic.secretserver/commit/73c96b9e668e3a3697c4b944d90979542961779e)
* `Get-TssFolderPermission` [#88](https://github.com/thycotic-ps/thycotic.secretserver/issues/88) [db137c2](https://github.com/thycotic-ps/thycotic.secretserver/commit/db137c29c687a7bf9f8dfe31935a0481e13ba5c5)
* `Search-TssFolderPermission` [#89](https://github.com/thycotic-ps/thycotic.secretserver/issues/89) [a128a5d](https://github.com/thycotic-ps/thycotic.secretserver/commit/a128a5d9c43600707e6f7b8b5c2b3777ee43359e)
* `Remove-TssFolderPermission` [#85](https://github.com/thycotic-ps/thycotic.secretserver/issues/85) [be7b661](https://github.com/thycotic-ps/thycotic.secretserver/commit/be7b66104879d33010be56ef7788a4499968e8b3)
* `Set-TssFolderPermission` [#87](https://github.com/thycotic-ps/thycotic.secretserver/issues/87) [93ba04f](https://github.com/thycotic-ps/thycotic.secretserver/commit/93ba04f7295244cbe8070da1d197954c0c395a24)
* `New-TssFolderPermission` [#86](https://github.com/thycotic-ps/thycotic.secretserver/issues/86) [528d24d](https://github.com/thycotic-ps/thycotic.secretserver/commit/528d24d34c82eb5277329f4fffebc12219d5fc13)

### Changed

* `Initialize-TssSdkClient` fixed issue with onboarding key being used [#84](https://github.com/thycotic-ps/thycotic.secretserver/issues/84) [c39f797](https://github.com/thycotic-ps/thycotic.secretserver/commit/c39f7972043ca5c81d9d7902cc69afa10f60696b)
* `Set-TssSecret` adjusting logic and workflow based on test failures [ad1cbd0](https://github.com/thycotic-ps/thycotic.secretserver/commit/ad1cbd0c6450dbcd33e91f081c7872224e8b7167)
* `Set-TssSecret` fixed [#90](https://github.com/thycotic-ps/thycotic.secretserver/issues/90) [2cf1016](https://github.com/thycotic-ps/thycotic.secretserver/commit/2cf101654bbdc53d035ac673b18372739c79e40b)
* `Get-TssFolderPermission` added part script [94de6e8](https://github.com/thycotic-ps/thycotic.secretserver/commit/94de6e85b5be3b89dd1c9ca88f707a886037c572)
* `Get-TssFolderPermissionStub` moved to use part script [24b17ae](https://github.com/thycotic-ps/thycotic.secretserver/commit/24b17ae082534f6ee4818baad5e380f9fb7fecd7)
* `Get-TssSecret` fixed [#91](https://github.com/thycotic-ps/thycotic.secretserver/issues/91) [dc9a811](https://github.com/thycotic-ps/thycotic.secretserver/commit/dc9a8111b335576c0ff89f2b7d6a186d86c27533)

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
