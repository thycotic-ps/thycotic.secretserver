# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## Unreleased -- 2021-xx-xx

### Breaking Changes

* None

### Bug Fixes

* None

### New Stuff

* None

### General Updates

* [33c1e41c](https://github.com/thycotic-ps/thycotic.secretserver/commits/33c1e41c7b09476c7be7df732e2ec260eba3cb0c) docs - correct links in command help
* [24654579](https://github.com/thycotic-ps/thycotic.secretserver/commits/246545798d5ff5be5ea4e0166a704a578edd5667) New-TssSession - Rework and add examples

### Tests

* None

## 0.60.5 -- 2021-11-20

### Breaking Changes

* None

### Bug Fixes

* [2b0d11f5](https://github.com/thycotic-ps/thycotic.secretserver/commits/2b0d11f573a1c61e14737adee037ddd2a7322a4b) Session class - set StartTime and TimeOfDeath in SessionRefresh method, fixes #253

### New Stuff

* None

### General Updates

* [16b0a72e](https://github.com/thycotic-ps/thycotic.secretserver/commits/16b0a72e07d6cc5272cb52412baa85b916b0fa3f) contributing guide - added Code task for formatting commit messages
* [4196aa42](https://github.com/thycotic-ps/thycotic.secretserver/commits/4196aa421d1793837b05edbe51afc63c292aaf42) vscode - adjusting extensions and enabling new color bracket setting

### Tests

* None

## 0.60.4 -- 2021-11-07

### Breaking Changes

* None

### Bug Fixes

* Secret Policy Item enum - update Item name to match API output [5772c82](https://github.com/thycotic-ps/thycotic.secretserver/commit/5772c8261bd7018c7f6fa9bc6fef4c78249f7187)
* Get-TssSecretPolicyItemStub - fixes error setting PolicyApplyType [ec35713](https://github.com/thycotic-ps/thycotic.secretserver/commit/ec35713a5dcf186973f933bf32c5b4c751b1ab7a)
* error handling - fix output 500 error content [eb23200](https://github.com/thycotic-ps/thycotic.secretserver/commit/eb2320029429b46120ba07084419066c71bc81f9)

### New Stuff

* None

### General Updates

* PolicyItem - Set Name to SecretPolicyItem Enum [bd8d67d](https://github.com/thycotic-ps/thycotic.secretserver/commit/bd8d67d2b7a569a288c2682c105d6befef02152a)

### Tests

* None

## 0.60.0 -- 2021-11-06

### Breaking Changes

* None

### Bug Fixes

* Search-TssSecretsByUrl - fixes [#246](https://github.com/thycotic-ps/thycotic.secretserver/issues/246) [57ff52d](https://github.com/thycotic-ps/thycotic.secretserver/commit/57ff52d9aa68ea9c2ee6f0f0edbb1e27d6b7f36a)
* Search-TssEventPipeline - correct PipelineName filter not working [8849345](https://github.com/thycotic-ps/thycotic.secretserver/commit/8849345591f929a7ec343df185ee6892ae7d68f5)
* Secret class - correct LastHeartbeatStatus type [2269e80](https://github.com/thycotic-ps/thycotic.secretserver/commit/2269e80e4d96a618479a42da4a0c9675331824eb)
* Find-TssSecret - adjusting parameter use and docs [2e48727](https://github.com/thycotic-ps/thycotic.secretserver/commit/2e4872762fd4a92e79ee9a5da271bbd0c8e900f3)
* Search-TssSecret - correcting issue where parameters were not being applied properly [9ddd3ae](https://github.com/thycotic-ps/thycotic.secretserver/commit/9ddd3ae53af854aedc06df9cba9f627be6d09d48)
* Search-TssSecret - fix syntax error on IncludeSubFolders param [f57b366](https://github.com/thycotic-ps/thycotic.secretserver/commit/f57b366d3a7d72cc7fef891f2c6e68e4fa8d30c1)
* Remove commands - correcting WhatIf support [8c74f6c](https://github.com/thycotic-ps/thycotic.secretserver/commit/8c74f6c0250da807cf25be421108959dfab806ee)
* Get-TssRpcPasswordType - correct endpoint, parameter help [8a84435](https://github.com/thycotic-ps/thycotic.secretserver/commit/8a844356feeea28404bf8b02d479319c6510b7f6)
* Search-TssRpcPasswordType - correct endpoint and class reference [8be9347](https://github.com/thycotic-ps/thycotic.secretserver/commit/8be9347e03938a6f98689a1fde251e8ce90c9566)
* SecretPolicyItem type - mapping update for HideLauncherPassword -> ViewingPasswordRequiresEdit [2f4e9d0](https://github.com/thycotic-ps/thycotic.secretserver/commit/2f4e9d01552fccea9ec6d439977d555b25525ac6)
* New-TssSession - issue with UseWindowsAuth param fixes [#247](https://github.com/thycotic-ps/thycotic.secretserver/issues/247) [2e66725](https://github.com/thycotic-ps/thycotic.secretserver/commit/2e66725d763297688d2f00f8a3af59aecdf69172)

### New Stuff

#### Lists

* Search-TssList - new command to return summary of the Lists created [d22d861](https://github.com/thycotic-ps/thycotic.secretserver/commit/d22d8617d46cf931fb982c2fcd620a8e0d7a6b4f)
* Get-TssListCategory - new command to return the categories on a List [d3cce97](https://github.com/thycotic-ps/thycotic.secretserver/commit/d3cce97d7b06406c265748c7762def3d9223b342)
* Add-TssListOption - new command to load Options for each category of a List [b0885f1](https://github.com/thycotic-ps/thycotic.secretserver/commit/b0885f12d4eab0fb7bb7e4e0f80468f2403bac80)
* Get-TssList - new command to get a given List object [dc70611](https://github.com/thycotic-ps/thycotic.secretserver/commit/dc70611ce26d06cf8689c3416b124bb23be06f87)
* Update-TssList - new command to update Active, Name and Description of a List [78a2774](https://github.com/thycotic-ps/thycotic.secretserver/commit/78a277479a6e4711bc555610a0a03976fffc3423)
* Remove-TssList - new command to "delete" a List [e731f42](https://github.com/thycotic-ps/thycotic.secretserver/commit/e731f427d7983eec28b12454c0077feffad3a93a)
* Clear-TssList - new command to clear the categories and options for a given List [fcbba21](https://github.com/thycotic-ps/thycotic.secretserver/commit/fcbba2196f1f05faf02514f2fe152a7687493e64)
* Get-TssListOption - new command to get Options from a List [2f611bc](https://github.com/thycotic-ps/thycotic.secretserver/commit/2f611bc0c51fc790e5a9265fa5bfffe0e7d89666)
* Clear-TssListOption - new command to clear specific options from a List [1d8bdba](https://github.com/thycotic-ps/thycotic.secretserver/commit/1d8bdbae9175520178ca6eb404d0d5b5da494976)
* Show-TssListCurrentUser - new command to retrieve the Lists the current user session can access [05c32ef](https://github.com/thycotic-ps/thycotic.secretserver/commit/05c32eff3a18f79930fc406edefbd519edacad36)
* New-TssList - new command to create a List(s) [a253fa2](https://github.com/thycotic-ps/thycotic.secretserver/commit/a253fa2199d095a362f954218a83121115807995)

### General Updates

* HeartbeatStatus enum - adjust params and property to use enumerator [45f3fb4](https://github.com/thycotic-ps/thycotic.secretserver/commit/45f3fb463f4f434deb7b6d29faed86e2ee733622)
* New-TssSecretTemplateField - convert Type param to enum [ac17a5f](https://github.com/thycotic-ps/thycotic.secretserver/commit/ac17a5f55efb0e371564175855989983ad93e6d0)
* Various commands - convert secret permissions param to enum [57307a4](https://github.com/thycotic-ps/thycotic.secretserver/commit/57307a48050510eff97ac47329e9915cdd2d1fa1)
* New-TssUser - convert TwoFactorType param to enum [e3414ba](https://github.com/thycotic-ps/thycotic.secretserver/commit/e3414ba97259894765a341dc0eaaae93671cd9d2)
* Test-TssSecretAction - convert Action param to enum [406b75c](https://github.com/thycotic-ps/thycotic.secretserver/commit/406b75cafccfc68dcf35eaed44ae70ed5603ee81)
* Test-TssSecretState - convert State param to enum [658106f](https://github.com/thycotic-ps/thycotic.secretserver/commit/658106f1be5e6f4b6574f89b5901741248479f05)
* Search-TssWorkflowTemplate - convert Type param to enum [6e98c79](https://github.com/thycotic-ps/thycotic.secretserver/commit/6e98c79c8e0c5d2de8c272b5997e44ce39a02ef3)
* Add support for NoAutoCheckout - option added in 11.0+ to not automatically checkout a secret [3b450cc](https://github.com/thycotic-ps/thycotic.secretserver/commit/3b450cc230a4e7fb758093f9e08929703d8d4cf6)

### Tests

* None

## 0.59.0 -- 2021-10-19

### Breaking Changes

* Search-TssDistributedEngineSite - rename SiteName param to SearchText to standardize search commands [d1b18a0](https://github.com/thycotic-ps/thycotic.secretserver/commit/d1b18a06e0da8aee2ebe7306936df88b824d8210)

### Bug Fixes

* Compare-TssVersion (internal command) - fixes [#243](https://github.com/thycotic-ps/thycotic.secretserver/issues/243) [28f64d1](https://github.com/thycotic-ps/thycotic.secretserver/commit/28f64d1dbc80a57075e146b269662058bb93d6f7)
* Export-TssAutoExportStorageItem - correct issue with downloading zip file for auto export [3510feb](https://github.com/thycotic-ps/thycotic.secretserver/commit/3510febf5c9d3cab9d42c40ff7aa4f1c07061d10)
* New-TssSession - bug fix when login failure stop throwing warning about version [aefa624](https://github.com/thycotic-ps/thycotic.secretserver/commit/aefa624a03f726a04feeda9104e06d6a094a3e21)
* Get-TssSecretField - correct error when called by Get-TssSecretAttachment [13d86b3](https://github.com/thycotic-ps/thycotic.secretserver/commit/13d86b33dc714d81e3e60fea895ccbf07ce0e234)
* Get-TssConfigurationAutoExport - correct examples fixes [#244](https://github.com/thycotic-ps/thycotic.secretserver/issues/244) [485e872](https://github.com/thycotic-ps/thycotic.secretserver/commit/485e87253be4ee4fc721b560d38ff8945d58d4c3)
* Auto Export - added check for SSC on Search and Export (these won't work with on-premises SS) [da50bff](https://github.com/thycotic-ps/thycotic.secretserver/commit/da50bfffa1ec5db8295a195ad057501c4dbc0c3a)

### New Stuff

* Move-TssFolder - new command to use for moving child folder [02ac0bf](https://github.com/thycotic-ps/thycotic.secretserver/commit/02ac0bf958470c5285a4ff86091409e6304e7f52)
* Get-TssDiagnosticConnectivityReport - new command to get the Internet connection test [a5b3425](https://github.com/thycotic-ps/thycotic.secretserver/commit/a5b3425daa40144a3c8af22a7ef5f580db25cd7a)
* Get-TssDiagnosticBackgroundProcess - new command to get the background process details [bd91027](https://github.com/thycotic-ps/thycotic.secretserver/commit/bd91027ca194040affa6e4dc1eb672b4a3d6ef5b)
* Get-TssSecretWebTemplate - new command to check Web Templates available, endpoint used by WPF [e9962a1](https://github.com/thycotic-ps/thycotic.secretserver/commit/e9962a15a507749e8a10595ce4df8ea29f2bd965)
* Search-TssSecretsByUrl - new command to check which Secret(s) is returned for a given URL, endpoint used by WPF [20dc14c](https://github.com/thycotic-ps/thycotic.secretserver/commit/20dc14c2af4f4cda61dff2b6c2edb30e7263c79c)

#### Server Nodes

* Search-TssServerNode - new command to get a list of all Server Nodes [fc97335](https://github.com/thycotic-ps/thycotic.secretserver/commit/fc97335a86f14c7540596aaf4b4420306fcb82a9)
* Update-TssServerNode - new command to update worker roles, readonly mode, and in cluster configuration for a server node [725cb59](https://github.com/thycotic-ps/thycotic.secretserver/commit/725cb59775aa6f2c1b0b12393edf9545db809e16)

#### Distributed Engine

* Search-TssDistributedEngine - new command to search for Engines [5113b7c](https://github.com/thycotic-ps/thycotic.secretserver/commit/5113b7c05bb889ae4cfbb4e88206d9312196f0c3)
* Get-TssDistributedEngineConfiguration - new command to pull the configuration details [370cb33](https://github.com/thycotic-ps/thycotic.secretserver/commit/370cb33b6495b7f6a95ffebe2243e6a4611d960f)
* Get-TssDistributeEngineConnectorCredential - new command to pull username/password for the connector [67c14d6](https://github.com/thycotic-ps/thycotic.secretserver/commit/67c14d60a9537e697dd0fd74cb2487af27a823a6)
* Get-TssDistributedEngineSite - new command to retrieve config and details of a Site [028a0aa](https://github.com/thycotic-ps/thycotic.secretserver/commit/028a0aa20b9db6ff0eda16e55c509e6b17fa6cba)
* Set-TssDistributedEngineSite - new command to adjust configuration of a Site [e9bd322](https://github.com/thycotic-ps/thycotic.secretserver/commit/e9bd3221a51c2fb11790cede556d95f3cfee6a35)
* Search-TssDistributedEngineConnector - new command to get list of Site Connectors [0052393](https://github.com/thycotic-ps/thycotic.secretserver/commit/005239329c3ed01c00e9de76d935ce68cd5b2bd9)
* Test-TssDistributedEngineCloudAccess - **new command to verify port access from DE to Secret Server Cloud** [0228004](https://github.com/thycotic-ps/thycotic.secretserver/commit/0228004971937311cf1e5073aa9ed332dbed528e)
* Set-TssDistributedEngine - new command to set configuration options for Distributed Engine global configuration [cb5f132](https://github.com/thycotic-ps/thycotic.secretserver/commit/cb5f132620f8b11da0f1184b48cb99dec9a2d3fc)
* Get-TssDistributedEngineServerCapabilities - new command to pull the OS details of a DE [8e77a5a](https://github.com/thycotic-ps/thycotic.secretserver/commit/8e77a5aa96a0a6764eb470868ff00aa5b9c449bf)
* Get-TssDistributedEngineSiteConnector - new command to get Site Connector details [282b503](https://github.com/thycotic-ps/thycotic.secretserver/commit/282b503683a29751d7fa289238afeccf0284c766)
* Set-TssDistributedEngineSiteConnector - new command to update configuration of a Site Connector [a4ff768](https://github.com/thycotic-ps/thycotic.secretserver/commit/a4ff768fcc3af533e4a87fe477681f475abce810)
* Get-TssDistributedEngineDownload - new command to download the installer for Site's DE [de7f664](https://github.com/thycotic-ps/thycotic.secretserver/commit/de7f664ff021dbd1e912fb0c5878bf9dc6383f7a)
* New-TssDistributedEngineSiteConnector - new command to create a Site Connector [05db5d6](https://github.com/thycotic-ps/thycotic.secretserver/commit/05db5d6809e4b73c7014750505b8862ac11a41d0)
* Test-TssDistributedEngineSiteConnector - new command to validate the Site Connector [a48e482](https://github.com/thycotic-ps/thycotic.secretserver/commit/a48e48270547da6c8046ad2ee1a65ab60b7040f9)
* Register-TssDistributedEngine - new command to activate a DE for a Site [0c9334b](https://github.com/thycotic-ps/thycotic.secretserver/commit/0c9334bbb6bf5d1b41b974783c9939f099c0fe6f)
* Update-TssDistributedEngine - new command to change the status of an Engine (e.g. activate, delete) [a340f72](https://github.com/thycotic-ps/thycotic.secretserver/commit/a340f720ec1dcae4402499a40e9ae02bd3914682)
* Remove-TssDistributedEngine - new command to delete a Distributed Engine (not reversible) [f5f560b](https://github.com/thycotic-ps/thycotic.secretserver/commit/f5f560be199c3ba0cc085db2abc6afabf490b782)
* Unregister-TssDistributedEngine - new command to deactivate a Distributed Engine for a Site [d7a3f55](https://github.com/thycotic-ps/thycotic.secretserver/commit/d7a3f55ab8f8754fdeaa916f35ecf23e536d8893)
* New-TssDistributedEngineSite - new command to create a Site [9ada9ed](https://github.com/thycotic-ps/thycotic.secretserver/commit/9ada9edbc752b331fae1328c1cff7daa467f9a2d)

### General Updates

* module - fix WhatIf output for internal code [8b88fe8](https://github.com/thycotic-ps/thycotic.secretserver/commit/8b88fe8ea0e07c25427ac87e809f6fef83d118aa)
* Get-TssFolderState - update warning message [9907d60](https://github.com/thycotic-ps/thycotic.secretserver/commit/9907d60b9c1fbaaa08b58c1b9b4a1e52bb639519)
* DistributedEngines - SiteSummary class add new property for v11 [7cdb432](https://github.com/thycotic-ps/thycotic.secretserver/commit/7cdb432f08a6a2657ab3f6958cb9d709d3a17864)
* Templates - Summary class add new property for 11.0.8 release [980d53d](https://github.com/thycotic-ps/thycotic.secretserver/commit/980d53d4043a9c94d4aa03427ba563f6e5a6780d)
* Get-TssDiagnostic - new command to get diagnostic info for on-premises [608485a](https://github.com/thycotic-ps/thycotic.secretserver/commit/608485adee4734feaa737b33556457b190c3c911)
* docs - authentication - updates, add PS Profile snippet [971b0b7](https://github.com/thycotic-ps/thycotic.secretserver/commit/971b0b734bf47fd3510be1805c6cec51fefa0592)
* docs - update, additions finding duplicate dependencies [f93ee34](https://github.com/thycotic-ps/thycotic.secretserver/commit/f93ee3467be25e30cd736581fce1fd2001e51ddd)
* Register-TssDistributedEngine - rewrite [bd8fb30](https://github.com/thycotic-ps/thycotic.secretserver/commit/bd8fb30e58f879160c07fe96b52c9b1060df700c)
* docs - expanding working with secrets content [6e75b7f](https://github.com/thycotic-ps/thycotic.secretserver/commit/6e75b7fda8229b0ccf921c759768758cf556b386)
* Set-TssDistributedEngineSite - corrections [1952309](https://github.com/thycotic-ps/thycotic.secretserver/commit/1952309204093d8024bdf339b7a4f69c7ed51620)
* Test-TssDistributedEngineCloudAccess - updated example URLs to show SSC [0c2db0a](https://github.com/thycotic-ps/thycotic.secretserver/commit/0c2db0abfa2ae46ff981fb7209fc6a988672b888)

### Tests

* None

## 0.58.0 -- 2021-10-01

### Breaking Changes

* None

### Bug Fixes

* Export-TssReport - fixes [#242](https://github.com/thycotic-ps/thycotic.secretserver/issues/242) [ba0ef31](https://github.com/thycotic-ps/thycotic.secretserver/commit/ba0ef318712cf2e5cdba2e116c1918d0f98dd709)

### New Stuff

* Get-TssDiscoveryStatus - new command to retrieve start/end date for discovery processing [33cf27f](https://github.com/thycotic-ps/thycotic.secretserver/commit/33cf27fe08dc3058457114a823909fe820b2d3b6)
* Search-TssIpRestriction - new command to search IP Address Restrictions [aa34f65](https://github.com/thycotic-ps/thycotic.secretserver/commit/aa34f656c2ed5716b37880031d3af2cde4f02c5c)
* Search-TssIpRestrictionGroup - new command to search IP Address Restrictions assigned to Groups [446b7cf](https://github.com/thycotic-ps/thycotic.secretserver/commit/446b7cfffe8e1e4850ab8c4796350affb77c9174)
* **Session - Add use of global variable, `$tss_ignoreversioncheck`, for disabling version check** [2c0ba2a](https://github.com/thycotic-ps/thycotic.secretserver/commit/2c0ba2ac42a7d985143f2227fe32d5ed1bef1a86)
* Remove-TssIpRestriction - new command to delete IP Address Restrictions [d63d657](https://github.com/thycotic-ps/thycotic.secretserver/commit/d63d657e9475c0d1f7cdefc896ffd5097221e052)
* Remove-TssIpRestrictionGroup - new command to remove IP assignments from Groups [b41b8e6](https://github.com/thycotic-ps/thycotic.secretserver/commit/b41b8e644abc6fedc9d1352d60bc3b0bbaae96c8)
* Remove-TssIpRestrictionUser - new command to remove IP restriction from Users [6edf4bb](https://github.com/thycotic-ps/thycotic.secretserver/commit/6edf4bb09915a2b426156a2fd4f9b38eb80e28d1)
* Search-TssIpRestrictionUser - new command to search IP Restrictions assigned to Users [e07a5c3](https://github.com/thycotic-ps/thycotic.secretserver/commit/e07a5c37bf67d9734136d9d078057c1c486ed707)
* New-TssIpRestriction - new command to create IP Address Restrictions [1af98a1](https://github.com/thycotic-ps/thycotic.secretserver/commit/1af98a195e72a8d0ed9e5ce8a12bd74ef0fe9b30)
* Set-TssIpRestrictionGroup - new command to set the IP Restriction for a Group(s) [6e40023](https://github.com/thycotic-ps/thycotic.secretserver/commit/6e4002383bad42d5768d336bcb6bfbe3d610f143)
* Set-TssIpRestrictionUser - new command to set the IP Restriction for a User(s) [668a567](https://github.com/thycotic-ps/thycotic.secretserver/commit/668a567b00be3e74fb1d9c455d482f62b9ba4330)
* Update-TssIpRestriction - new command to update name or range of an IP Address Restriction [02c046a](https://github.com/thycotic-ps/thycotic.secretserver/commit/02c046a57043d3f2db0244b0ce05d28112e0401b)

### General Updates

* module GetInvocation - converting private binary command, Get-TssInvocation [2e5ceac](https://github.com/thycotic-ps/thycotic.secretserver/commit/2e5ceac826eb5d3e47b418f8ac97fb789611ac9f)
* module CheckVersion - convert to private binary command, Compare-TssVersion [0568794](https://github.com/thycotic-ps/thycotic.secretserver/commit/0568794fc7feb0e9ce90564629e095c9db9055df)
* module InternalEndpointUsed - converting to private binary command, Write-TssInternalNote [d3b19f9](https://github.com/thycotic-ps/thycotic.secretserver/commit/d3b19f98ef37adbeaf9f4947f0a6a6de43c2b4f3)
* Template classes - added enumerators [3289f90](https://github.com/thycotic-ps/thycotic.secretserver/commit/3289f9096a5513ca401a3e7e75574ef14b11645c)
* Format - cleaning up, fixing references [e219f1a](https://github.com/thycotic-ps/thycotic.secretserver/commit/e219f1aee2120a2c80703ab84b037ef4697bf2f7)

### Tests

* None

## 0.57.0 -- 2021-09-15

### Breaking Changes

* None

### Bug Fixes

* Get-TssSecret - fixes [#236](https://github.com/thycotic-ps/thycotic.secretserver/issues/236) [639e810](https://github.com/thycotic-ps/thycotic.secretserver/commit/639e81008c3dde5dbb693f1b7ed0668610ce7fdc)
* Search-TssDirectoryServiceDomain - fixed inactive results when param not provided [e2632cc](https://github.com/thycotic-ps/thycotic.secretserver/commit/e2632cc00ed96c03a53efec4b80b2dbca911bdb1)
* New-TssSession - fixes [#241](https://github.com/thycotic-ps/thycotic.secretserver/issues/241) [90343b3](https://github.com/thycotic-ps/thycotic.secretserver/commit/90343b37979e8cf79d9831dbec1424e2a55bdf28)

### New Stuff

* Get-TssDirectoryServiceSyncStatus - new command [0a8dd94](https://github.com/thycotic-ps/thycotic.secretserver/commit/0a8dd944b196909125bbdeaf86cf347a99448854)
* Start-TssDirectoryServiceSync - new command [fb4edce](https://github.com/thycotic-ps/thycotic.secretserver/commit/fb4edce2ccdbe44e5584eeb2756754a73ea53041)
* Get-TssDirectoryServiceDomain - new command [86523d9](https://github.com/thycotic-ps/thycotic.secretserver/commit/86523d9b902c6b70ce73f2c7d1a82ba621dd353b)
* Remote-TssDirectoryServiceGroup - new command Remove a group from the Directory Service sync [4dd8f5e](https://github.com/thycotic-ps/thycotic.secretserver/commit/4dd8f5eb264a9cd7bd4e8d4e7325f21ba8a22e68)
* Add-TssDirectoryServiceGroup - new command Add a Domain Group to Directory Service for sync [947e2b3](https://github.com/thycotic-ps/thycotic.secretserver/commit/947e2b390a72d0dac289a8cfad7eb9010754cc81)
* Search-TssDirectoryServiceGroup - new command Return groups that can be added for sync in a Directory Service [48c0935](https://github.com/thycotic-ps/thycotic.secretserver/commit/48c093575d4c98ece758474727f23644d3cd5efd)
* Search-TssDirectoryServiceGroupMember - new command searching for member of Directory Service Group [02a10f4](https://github.com/thycotic-ps/thycotic.secretserver/commit/02a10f430afdd5b62429a91705b6a406eaaa23d9)
* New-TssDirectoryService - new command to create domains [8b99a38](https://github.com/thycotic-ps/thycotic.secretserver/commit/8b99a38de1a35330783baf205049d025d8bd3713)

### General Updates

* New-TssFolder - correcting examples [717e2be](https://github.com/thycotic-ps/thycotic.secretserver/commit/717e2beb69ec78c033f3687d62180613a4120bc2)
* Invoke-TssReport - update help description [80330a1](https://github.com/thycotic-ps/thycotic.secretserver/commit/80330a14b33752bae71c46954d89a2a3ca985380)
* Start-TssSecretChangePassword - correct verbose output [11996cf](https://github.com/thycotic-ps/thycotic.secretserver/commit/11996cfc4577e1d241e6262d018abd17f4f98914)

### Tests

* None

## [0.56.0] -- 2021-09-08

### Breaking Changes

* Set-TssSecretPolicy - updated to accept Policy Item object [a63f059](https://github.com/thycotic-ps/thycotic.secretserver/commit/a63f059108adf4e9cbb012bf970fde19a84fb63a)

### Bug Fixes

* Auth - Windows Authentication fixed closes #234 [270e5b1](https://github.com/thycotic-ps/thycotic.secretserver/commit/270e5b1aac12eb6b81945c5fc7aac095f904ee6e)

### New Stuff

* New-TssSecretPolicy - add support for Policy Items [3795366](https://github.com/thycotic-ps/thycotic.secretserver/commit/37953660c20cf79e7c5fc29fc186b8548b30e912)
* Get-TssSecretPolicyStub - new command [ab76896](https://github.com/thycotic-ps/thycotic.secretserver/commit/ab76896845023cab4c99fc00e2407988afbf48c6)
* Get-TssSecretPolicyItemStub - new command [ba42045](https://github.com/thycotic-ps/thycotic.secretserver/commit/ba42045e840ff33fa5152f93440be12525bd2889)

### General Updates

* bump library to netstandard 2.1 [aba7931](https://github.com/thycotic-ps/thycotic.secretserver/commit/aba79312997ea0876e1a65f7337e553730baf977)
* Contributing guide - Updates to software list, added shortcut info [31ee833](https://github.com/thycotic-ps/thycotic.secretserver/commit/31ee83377f591a878895a8e982f0501932070867)

### Tests

* None

## [0.54.0] -- 2021-09-03

### Breaking Changes

* None

### Bug Fixes

* New-TssSession - convert OAuth call to internal binary command fixes [#233](https://github.com/thycotic-ps/thycotic.secretserver/issues/233) [06e6477](https://github.com/thycotic-ps/thycotic.secretserver/commit/06e6477b27d73f60f460572f8992e67b8c62f08c)

### New Stuff

* Get-TssSecretDependencyScript - new command [8cf4332](https://github.com/thycotic-ps/thycotic.secretserver/commit/8cf433278dec51c15b3ac20da78a7e76d4dec99b)
* Set-TssConfigurationLocalUserPassword - new command [7b6ab4b](https://github.com/thycotic-ps/thycotic.secretserver/commit/7b6ab4bd1ae4489b1f6d7eb16cca27df23d2acd1)
* Set-TssConfigurationSecurity - new command [8c0c4e8](https://github.com/thycotic-ps/thycotic.secretserver/commit/8c0c4e81371d252e545e227cfb5bde1c4e5692d0)
* Set-TssConfigurationLogin - new command [6cbdec2](https://github.com/thycotic-ps/thycotic.secretserver/commit/6cbdec2cdfd7137ccc9f966d294f75323b49ae43)
* Set-TssConfigurationRpc - new command [1bbe020](https://github.com/thycotic-ps/thycotic.secretserver/commit/1bbe020219dcdfcafe0d0c50d3d12bcd3006ce42)

### General Updates

* None

### Tests

* None

## [0.53.0] -- 2021-08-30

### Breaking Changes

* Get-TssConfigurationSearchIndex - rename of Get-TssConfigurationSecretIndexer -- breaking change [348343d](https://github.com/thycotic-ps/thycotic.secretserver/commit/348343d14a9aba14092e7d704470484bc6fd3d50)

### Bug Fixes

* None

### New Stuff

* New-TssScript - new command [efb4871](https://github.com/thycotic-ps/thycotic.secretserver/commit/efb4871f975d4d23249de529164232984e320c0c)
* Get-TssSecretAccessRequest - new command [a858c90](https://github.com/thycotic-ps/thycotic.secretserver/commit/a858c90af3d610ecbb6a8ebc04fbb6e2e440ff94)
* Update-TssSecretAccessRequest - new command [ca09f56](https://github.com/thycotic-ps/thycotic.secretserver/commit/ca09f5685a401e445cf60deb65f70eaf2e54b5fb)
* New-TssSecretPolicy - new command [45bfda9](https://github.com/thycotic-ps/thycotic.secretserver/commit/45bfda92ce155355f6c21e043056890e54cdde41)
* Get-TssConfigurationBackup - new command [7316419](https://github.com/thycotic-ps/thycotic.secretserver/commit/731641946843756a5cda1691b3b5c4d2512c00e1)
* Search-TssConfigurationBackupLog - new command [7c5bb0c](https://github.com/thycotic-ps/thycotic.secretserver/commit/7c5bb0c106c501a5686bb13ab9789f457ddba418)
* Start-TssConfigurationBackup - new command [2991b7e](https://github.com/thycotic-ps/thycotic.secretserver/commit/2991b7e4277b79eced652659c6d9e26b79dbfc41)
* Start-TssConfigurationSearch - new command [6a724f1](https://github.com/thycotic-ps/thycotic.secretserver/commit/6a724f170334e1b64c61b064eaef2a8898c8e97a)

### General Updates

* Set-TssSecretPolicy - correct Items param type [15621d3](https://github.com/thycotic-ps/thycotic.secretserver/commit/15621d3c9c793b5aa46ff56ec64dd53d281d8cb7)

### Tests

* None

## [0.52.0] -- 2021-08-23

### Breaking Changes

* Get-TssConfiguration - adjust output to only output based on Type value [554ed6b](https://github.com/thycotic-ps/thycotic.secretserver/commit/554ed6b4711ac9541f5324e54682cbd100445386)

### Bug Fixes

* Metadata - correct issue with ItemType parameter not applying properly [5fbf281](https://github.com/thycotic-ps/thycotic.secretserver/commit/5fbf281640f0bbd42f7b3c745c9f22692537afa9)
* User object - 11.0 release new properties added [22e9d12](https://github.com/thycotic-ps/thycotic.secretserver/commit/22e9d12da5173c8a17af1e08f7f88a524d23bc62)
* Remove-TssReportSchedule - correct piping support [f7cb1cd](https://github.com/thycotic-ps/thycotic.secretserver/commit/f7cb1cdbb76fdfc73899a934a81e4b8e8ae3186d)
* Get-TssReportSchedule - Correct pipeline support [25c3b63](https://github.com/thycotic-ps/thycotic.secretserver/commit/25c3b6353901ef6f2ff751233cddc287982fdc52)

### New Stuff

* Search-TssMetadataHistory - new command [8994a53](https://github.com/thycotic-ps/thycotic.secretserver/commit/8994a53b209b534c4e3673fc5f375f2d6acb648e)
* Close-TssSession - new command [08b420c](https://github.com/thycotic-ps/thycotic.secretserver/commit/08b420c5d3e08a13b91a07ba1f1ff59ba27671ee)
* Get-TssReportSchedule - new command closes [#46](https://github.com/thycotic-ps/thycotic.secretserver/issues/46) [33822cf](https://github.com/thycotic-ps/thycotic.secretserver/commit/33822cfabf2de25a39119e3e2544ff38f51f6929)
* Remove-TssReportSchedule - new command closes [#43](https://github.com/thycotic-ps/thycotic.secretserver/issues/43) [87ed599](https://github.com/thycotic-ps/thycotic.secretserver/commit/87ed599c80815f1bb9744823780635b6bce0ee3f)
* New-TssReportSchedule - new command closes [#45](https://github.com/thycotic-ps/thycotic.secretserver/issues/45) [0c4add9](https://github.com/thycotic-ps/thycotic.secretserver/commit/0c4add951944cca58ded8ed3cf884c6a7889edd4)
* Search-TssConfigurationAudit - new command [62c5f5a](https://github.com/thycotic-ps/thycotic.secretserver/commit/62c5f5a8b6659e04c7ac2fdb2ec41a945a8ea13a)
* Get-TssConfigurationLocalUsePassword - new command [7a4cf49](https://github.com/thycotic-ps/thycotic.secretserver/commit/7a4cf49011e59e34ffc691210ea311e50cf99b16)
* Get-TssConfigurationLogin - new command [1b353b3](https://github.com/thycotic-ps/thycotic.secretserver/commit/1b353b39bdfedb694d2d776366662b24a98c02fd)
* Get-TssConfigurationSaml - new command [991a940](https://github.com/thycotic-ps/thycotic.secretserver/commit/991a9401bed4620ed25d66db030a35343032c1f0)
* Get-TssConfigurationSecurity - new command [184dc0d](https://github.com/thycotic-ps/thycotic.secretserver/commit/184dc0db06935c09dcde51432f26e390efb424d4)
* Get-TssConfigurationRpc - new command [b771ac0](https://github.com/thycotic-ps/thycotic.secretserver/commit/b771ac091f318ca1ec1213e0a0c67ee5d3259685)
* Set-TssConfigurationGeneral - new command covers folders, permission options and user experience settings [cebf3df](https://github.com/thycotic-ps/thycotic.secretserver/commit/cebf3df61083bb86f34af79652df2d17bc587e1f)
* Test-TssSession - new command also closes [#229](https://github.com/thycotic-ps/thycotic.secretserver/issues/229) [515d2f7](https://github.com/thycotic-ps/thycotic.secretserver/commit/515d2f75ba62143e6768fbf61a3e385a70fb64d2)
* Get-TssConfigurationSiteConnector - new command [af22ef6](https://github.com/thycotic-ps/thycotic.secretserver/commit/af22ef6726e0922914f1635445407502511b8bdc)
* Get-TssConfigurationSecretIndexer - new command [7e47c36](https://github.com/thycotic-ps/thycotic.secretserver/commit/7e47c367bfc3fe5dce3443d52178dfa2aa9f3ad2)
* Get-TssConfigurationAutoExport - new command [5649af6](https://github.com/thycotic-ps/thycotic.secretserver/commit/5649af615d4d795a3d14e896ab043125031c4e15)
* Set-TssConfigurationAutoExport - new command [52f6299](https://github.com/thycotic-ps/thycotic.secretserver/commit/52f629943c0df136d29fbe831717cc8b78b0f75b)
* Export-TssAutoExportStorageItem - new command [929f371](https://github.com/thycotic-ps/thycotic.secretserver/commit/929f37136247f9679481c600700f19ba4304d1a4)

### General Updates

* New-TssSession - adding verbose content [503ee21](https://github.com/thycotic-ps/thycotic.secretserver/commit/503ee21125b3293adfbf5113620a2ea7d2de241b)
* Find-TssReport - adjust param order [3a229ae](https://github.com/thycotic-ps/thycotic.secretserver/commit/3a229aee65c5ed0ae7f23025d27d3f3f733a42c0)
* Authentication.Session - change internal class to private [8fb36c1](https://github.com/thycotic-ps/thycotic.secretserver/commit/8fb36c159e9369561eaa0eeec3db09c6f4d76119)
* module - changing verbose URI reference [e7fe007](https://github.com/thycotic-ps/thycotic.secretserver/commit/e7fe0079834ea0663aeb3ad91454e5356af30dc6)
* Set-TssConfigurationGeneral - correct doc links [ad76461](https://github.com/thycotic-ps/thycotic.secretserver/commit/ad764614e5be6953601d68c067798078f8fd18b1)
* report commands - fix help link [10f04c2](https://github.com/thycotic-ps/thycotic.secretserver/commit/10f04c277c906fd3a50be04191a34cd438eafe2c)
* Search-TssAutoExportStorage - new command [40aa723](https://github.com/thycotic-ps/thycotic.secretserver/commit/40aa7232307f3bb3f601cb6410d32f17d80e645d)

### Tests

* None

## [0.51.0] -- 2021-08-17

### Breaking Changes

* Metadata - standardize on ItemType parameter [f0f2279](https://github.com/thycotic-ps/thycotic.secretserver/commit/f0f2279212bb530cb5bda70213d82d01a8b7228a)

### Bug Fixes

* Set-TssSecret - EnableInheritPermission logic fixes [#226](https://github.com/thycotic-ps/thycotic.secretserver/issues/226) [c79a7f4](https://github.com/thycotic-ps/thycotic.secretserver/commit/c79a7f46d1df56ddb0bec789a11a3260b6ef00e4)

### New Stuff

* Remove-TssMetadata - new command [64749a1](https://github.com/thycotic-ps/thycotic.secretserver/commit/64749a1023c83c5a12fa01ffed85df964151a48e)
* Search-TssMetadataFieldSection - new command [4f5ba25](https://github.com/thycotic-ps/thycotic.secretserver/commit/4f5ba2560e6890db1e1754e9b4e4403303359aaa)
* Get-TssMetadataField - new command [cd12a48](https://github.com/thycotic-ps/thycotic.secretserver/commit/cd12a48dd483e1a4a5422aa708d9468286bfacad)
* New-TssMetadataField - new command [583db9d](https://github.com/thycotic-ps/thycotic.secretserver/commit/583db9dba18e784f24856ffc8a79bafddbb23442)
* Update-TssMetadataSection - new command [6afe585](https://github.com/thycotic-ps/thycotic.secretserver/commit/6afe5855eff34cd4b3e7e4ff8b6a2eb79cc8fdd8)
* Update-TssMetadataField - new command [9e1603e](https://github.com/thycotic-ps/thycotic.secretserver/commit/9e1603e5e6473d16a4289791bf99499d1785cbd9)

### General Updates

* Search-TssMetadata - correction/updates to parameter type and help [028c4f2](https://github.com/thycotic-ps/thycotic.secretserver/commit/028c4f263f5f02495c3e2e28c5a1d2e5dd940586)

### Tests

* Tests - correct failures [039f56b](https://github.com/thycotic-ps/thycotic.secretserver/commit/039f56b6dda36c854607ee65b312f113416153b1)

## [0.50.1] -- 2021-08-10

### Breaking Changes

* None

### Bug Fixes

* Fix Windows PowerShell support for processing API call [b09c145](https://github.com/thycotic-ps/thycotic.secretserver/commit/b09c1455aa1797f41eae94b70e3a86a796bc95b6)

### New Stuff

* None

### General Updates

* None

### Tests

* None

## [0.50.0] -- 2021-08-10

### Breaking Changes

* None

### Bug Fixes

* Adjust FolderPermissions Class - rename namespace and classes, align functions fixes [#215](https://github.com/thycotic-ps/thycotic.secretserver/issues/215) [9c00b69](https://github.com/thycotic-ps/thycotic.secretserver/commit/9c00b69fd727e38a8848f1b2e45568d55694d306)

### New Stuff

* Invoke-TssApi - internal cmdlet for web request Additional scripts added to accommodate processing web request output [da45da6](https://github.com/thycotic-ps/thycotic.secretserver/commit/da45da6d5b3a65ab622520ffccecdda40d25ea0c)
* Search-TssEventPipeline - rename of Get-TssEventPipelineList [e9fcf83](https://github.com/thycotic-ps/thycotic.secretserver/commit/e9fcf834c6a43625462737cbf25a04cb80745204)
* Search-TssSecretAccessRequest - new command [7d7f0c8](https://github.com/thycotic-ps/thycotic.secretserver/commit/7d7f0c8ee7df547c870781d399d868e9c6bb2a2b)
* Get-TssEventPipelinePolicy - new command [466cb26](https://github.com/thycotic-ps/thycotic.secretserver/commit/466cb26e1c839a951eb8cf3fb9d3749bcac46836)
* Enable/Disable-TssEventPipeline - new commands [30de5c7](https://github.com/thycotic-ps/thycotic.secretserver/commit/30de5c7608a26c311a692139a677b653a1844cfa)
* Search-TssEventPipelinePolicy - new command [1f2303b](https://github.com/thycotic-ps/thycotic.secretserver/commit/1f2303b6635e2eb31bc8a1a51aca4bc0cd8c1175)
* Search-TssEventPipeline - new command [46d9263](https://github.com/thycotic-ps/thycotic.secretserver/commit/46d9263d5f76c24b589349fb0884d8f70c227e43)
* Get-TssEventPipeline - new command [76f5092](https://github.com/thycotic-ps/thycotic.secretserver/commit/76f50927a15a83da92ce852b83a24a7df3a22a45)
* Get-TssEventPipelineRun - new command [80ff0c2](https://github.com/thycotic-ps/thycotic.secretserver/commit/80ff0c2cb3901285094d6ce450a30cca1b930d38)
* Get-TssEventPipelinePolicyActivity - new command [793d418](https://github.com/thycotic-ps/thycotic.secretserver/commit/793d418547f1772b978ca269b9e5261df9ca0245)
* Add/Remove-TssEventPipeline - new command to add/remove pipelines from an Event Pipeline Policy [13ae3d6](https://github.com/thycotic-ps/thycotic.secretserver/commit/13ae3d6d83df3432a01ebc8be11d5fbea9f6c01b)
* Enable/Disable-TssEventPipelinePolicy - new commands [0ad7fa7](https://github.com/thycotic-ps/thycotic.secretserver/commit/0ad7fa7c8b77b04eccfe274bd774bfc7b86c2088)
* Write-TssSecretAccessRequestViewComment - new command [c537ce5](https://github.com/thycotic-ps/thycotic.secretserver/commit/c537ce5e609cb87328d74db3e338ab7755f9c8cf)
* Get-TssFolder - add 11.0 support for FolderPath functionality [0c406e3](https://github.com/thycotic-ps/thycotic.secretserver/commit/0c406e39fcf91994d50c539d1717498d8d0e75fd)
* Get-TssSecret - add 11.0 support for Secret Path functionality [ba44fc3](https://github.com/thycotic-ps/thycotic.secretserver/commit/ba44fc39652d216d7247a7562c72ae3eeb2b5f17)
* Get-TssSecretPolicy - new command [ef41109](https://github.com/thycotic-ps/thycotic.secretserver/commit/ef41109fcf2276a0ba94b3c0f6a745406a3f1122)
* Set-TssSecretPolicy - new command partial as some policy items are excluded [e31b1e2](https://github.com/thycotic-ps/thycotic.secretserver/commit/e31b1e2e51568fb803612948951b25d44489582a)
* Search-TssSystemLog - new command [6ca69de](https://github.com/thycotic-ps/thycotic.secretserver/commit/6ca69de2da9a20c07a91a5a16b0449a3f10347ad)

### General Updates

* Search-TssEventPipeline - switched endpoint to summaries [5f3b046](https://github.com/thycotic-ps/thycotic.secretserver/commit/5f3b0468b7e4f06c68f4eaa7b6cced75de517517)
* New-TssSecretPermission - replace parts call with command [fae43be](https://github.com/thycotic-ps/thycotic.secretserver/commit/fae43beaf053ddd9376b0dca08d88a8f7a9eec31)
* Secrets commands - convert to internal cmdlet Invoke-TssApi [c86ab78](https://github.com/thycotic-ps/thycotic.secretserver/commit/c86ab78fe002442a224c94f0f5db97a79d15ba57)
* Secret Audit - add username property [085a8b6](https://github.com/thycotic-ps/thycotic.secretserver/commit/085a8b66a72111d35835cb95728b7cc8a2a93108)
* remove use of CheckOutSecret part [3fdac6e](https://github.com/thycotic-ps/thycotic.secretserver/commit/3fdac6eda2c0dc11e4bfaeb41a07827b5a3448fb)
* secrets - correct part reference [dc8d55f](https://github.com/thycotic-ps/thycotic.secretserver/commit/dc8d55fe9958e17e448a38bb052d36415f3b8394)
* Get/Test-TssVersion - rework code, adjust classes (now has major, minor, build properties [e314712](https://github.com/thycotic-ps/thycotic.secretserver/commit/e3147128e463684bc2efce425529d9ea1c8b07db)
* class rename general --> common [50e158c](https://github.com/thycotic-ps/thycotic.secretserver/commit/50e158c884f31d84a5bd0b97800f1909f6c7c2e0)
* Convert to web request call [dff37d0](https://github.com/thycotic-ps/thycotic.secretserver/commit/dff37d00452a374fb671fc24653c0cc3c4c8d866)
* Search-TssSecretPolicy - rename class [7b77508](https://github.com/thycotic-ps/thycotic.secretserver/commit/7b775089ade1825db232f6a5b47a29a4a26c1481)

### Tests

* None

## [0.49.0] -- 2021-07-26

### Breaking Changes

* Get-SecretRpcAssociated - rename --> Get-RpcAssociatedSecret breaking change [6cf7e9e](https://github.com/thycotic-ps/thycotic.secretserver/commit/6cf7e9ea9458d3980b0b725f40d71f1c40f45712)

### Bug Fixes

* Set-TssSecretRpcPrivileged - update examples fixes [#209](https://github.com/thycotic-ps/thycotic.secretserver/issues/209) [641d16c](https://github.com/thycotic-ps/thycotic.secretserver/commit/641d16c237a1671e1f9c1ce56c46c7a480196be1)

### New Stuff

* Configurations - class conversion [6327c11](https://github.com/thycotic-ps/thycotic.secretserver/commit/6327c11a7468b326e8f56511b75e23423061b7db)
* Directory Services - class conversion [353153c](https://github.com/thycotic-ps/thycotic.secretserver/commit/353153cb47a2b1fbe8504efdd7e6c53e566c9884)
* DistributedEngines - class conversion [962a5e5](https://github.com/thycotic-ps/thycotic.secretserver/commit/962a5e502641c118e67319828d70033cecf87977)
* FolderPermission - class conversion [6feec97](https://github.com/thycotic-ps/thycotic.secretserver/commit/6feec97eec0cee1a00d916ff86eb5c88b5e9683c)
* General - class conversion (Delete, Site, VersionSummary) [734592d](https://github.com/thycotic-ps/thycotic.secretserver/commit/734592da30ca69e43c00eb555bea1a632083670a)
* Folders - class conversion [0cf5cd7](https://github.com/thycotic-ps/thycotic.secretserver/commit/0cf5cd7203ab6e1ca5efcbb5727cb2feaee3a94b)
* Groups - class conversion [107ce3c](https://github.com/thycotic-ps/thycotic.secretserver/commit/107ce3c15711272aab4ae6c6be45337ecb925d9a)
* Reports - class conversion [8374bf9](https://github.com/thycotic-ps/thycotic.secretserver/commit/8374bf999c5f6a40c98e44384057788251873b43)
* Roles - class conversion [abf902c](https://github.com/thycotic-ps/thycotic.secretserver/commit/abf902c34093857cab21f6e543e7ba676345e45c)
* RPC - class conversion [b986909](https://github.com/thycotic-ps/thycotic.secretserver/commit/b98690910358bc7aaba816ae1d2ac4313db54f72)
* Scripts - class conversion [43d0f47](https://github.com/thycotic-ps/thycotic.secretserver/commit/43d0f475ff17ae8bd2f336560e54ad2a091f94fe)
* SecretAccessRequest - class conversion [1036884](https://github.com/thycotic-ps/thycotic.secretserver/commit/1036884ed81c36eafc4e55e7efe25ab2ce2357d5)
* SecretDependencies - class conversion [33f8300](https://github.com/thycotic-ps/thycotic.secretserver/commit/33f8300cc6c9bf1152a89a16a6d7fc6ae0fb264e)
* SecretHooks - class conversion [33e4910](https://github.com/thycotic-ps/thycotic.secretserver/commit/33e4910accf8d89adf62421f0989e0135994b4cb)
* Items - class update, add list properties for SS v11 [d3fcb98](https://github.com/thycotic-ps/thycotic.secretserver/commit/d3fcb98e053cd37fa78bb850493274deebe33f52)
* SecretPermissions - class conversion [f93b96a](https://github.com/thycotic-ps/thycotic.secretserver/commit/f93b96a15c71081d3df65b36ff259a27ac50e0b8)
* SecretPolicies - class conversion [947eea3](https://github.com/thycotic-ps/thycotic.secretserver/commit/947eea397c36f1b59ac86bc6e8821e8f6921e5d6)
* SecretTemplates - class conversion [7fb658b](https://github.com/thycotic-ps/thycotic.secretserver/commit/7fb658b81ff6ca3bb3766f12a3ce67e08e7dc9db)
* WorkflowTemplates - class conversion Also added support for SecretEraseRequest Type [1652259](https://github.com/thycotic-ps/thycotic.secretserver/commit/16522595d9e5c98b800654347b7590fc31b57b2a)
* Users - class conversion [20552e5](https://github.com/thycotic-ps/thycotic.secretserver/commit/20552e5e1f0a9a79a117c6627770c09ef939813f)

### General Updates

* test import action - update build and import test workflow [337b014](https://github.com/thycotic-ps/thycotic.secretserver/commit/337b01441f0ab84af008dfb4371d299b81ecb27b)
* Secrets - rename about pages [64aa85e](https://github.com/thycotic-ps/thycotic.secretserver/commit/64aa85e5b8ce4654048c9f39e9c1aaa1b1639e66)
* Class - types and format view update [7e4f57c](https://github.com/thycotic-ps/thycotic.secretserver/commit/7e4f57cc3fbcf5cc03ca2ed2375fbcb3f0a44398)
* RPC Class - correcting file name [dad12a0](https://github.com/thycotic-ps/thycotic.secretserver/commit/dad12a0a8bb521c51cf532904becac139fa3c622)
* Update-SecretRpdLauncherSetting - correct from test failure [ed745ae](https://github.com/thycotic-ps/thycotic.secretserver/commit/ed745ae11aa4462d14ee2121542a41d94e0115c8)
* psd1 - remove CommandPrefix, add FunctionsToExport [98ca7af](https://github.com/thycotic-ps/thycotic.secretserver/commit/98ca7af6c1e5815ed2be0ff0f91008a9253fecdf)
* psm1 - update alias references with Tss prefix [cac7a3a](https://github.com/thycotic-ps/thycotic.secretserver/commit/cac7a3a703012939a4319bd090feac58dd800562)
* Functions - add Tss prefix [4b2d962](https://github.com/thycotic-ps/thycotic.secretserver/commit/4b2d9620989491ec58f36e5fa3c1aac836a6786d)
* Logging commands - add Tss prefix [e3bb997](https://github.com/thycotic-ps/thycotic.secretserver/commit/e3bb9975614fe45e12ae359ed7878299dac4e5b8)
* testimport - update to run on pull request [bcd111b](https://github.com/thycotic-ps/thycotic.secretserver/commit/bcd111b785569d08d380742724c9d3365f83e9d0)

### Tests

* Test - Correct references [bc37232](https://github.com/thycotic-ps/thycotic.secretserver/commit/bc3723289e2639907dc20d31851c964f6d6e6194)
* Tests - add Tss prefix [fa66d4f](https://github.com/thycotic-ps/thycotic.secretserver/commit/fa66d4f998dbff81504ae90e9af76a5ff61f7c91)

## [0.48.1] -- 2021-07-23

### Breaking Changes

* None

### Bug Fixes

* Write-Log - fixes [#202](https://github.com/thycotic-ps/thycotic.secretserver/issues/202) [214da74](https://github.com/thycotic-ps/thycotic.secretserver/commit/214da7405b413dce539a0e3de007335411e6cbc7)
* Secret class - rework GetFileFields() method fixes [#203](https://github.com/thycotic-ps/thycotic.secretserver/issues/203) [25e7b6b](https://github.com/thycotic-ps/thycotic.secretserver/commit/25e7b6b583ff5e3b2f4f823ba6e1b007b1acf061)
* Format file - fixes spelling error, adjust view names fixes [#204](https://github.com/thycotic-ps/thycotic.secretserver/issues/204) [c28e309](https://github.com/thycotic-ps/thycotic.secretserver/commit/c28e30929cd833db04bd92faf2159308355a0ec2)
* Get-Secret - Correct types reference fixes [#205](https://github.com/thycotic-ps/thycotic.secretserver/issues/205) [d3911dd](https://github.com/thycotic-ps/thycotic.secretserver/commit/d3911dd0cd7cab4ee2e1e624a35c428f5b1539ff)
* Start-Log - adjust file validation, add proper dispose fixes [#206](https://github.com/thycotic-ps/thycotic.secretserver/issues/206) [ca4e98f](https://github.com/thycotic-ps/thycotic.secretserver/commit/ca4e98f851543dae1706647b88a82bf6a20f7253)
* Set-SecretField - correct Path validation [fc4eb48](https://github.com/thycotic-ps/thycotic.secretserver/commit/fc4eb485952c5c048458de1b6ef18f40b9c8d1de)
* Set-Secret - fixing various issues with some of the parameters [669ed26](https://github.com/thycotic-ps/thycotic.secretserver/commit/669ed26159f37461ad6c283f45388279265efe88)
* Secret class - GetFieldValue method issue with empty value [3d3f0eb](https://github.com/thycotic-ps/thycotic.secretserver/commit/3d3f0eb8d82a0865c9ee2b19f03c7388cc1014ac)

### New Stuff

* None

### General Updates

* TssSecretTemplateField - add SecretTemplateFieldId to default view [3a6f207](https://github.com/thycotic-ps/thycotic.secretserver/commit/3a6f2071c46d5afcb9e4cf72a5e2ce3dfd1b9ed4)
* TssFolderPermissionSummary - adjust default table view [b12828e](https://github.com/thycotic-ps/thycotic.secretserver/commit/b12828e260bc728597769ea65ecd36cb6420ddd2)

### Tests

* None

## [0.48.0] -- 2021-07-20

### Major Changes

* Logging commands - converted to cmdlets [0096aa7](https://github.com/thycotic-ps/thycotic.secretserver/commit/0096aa7f83202105004e3b6133ac12502660bc87)
* module - update TssSession --> Thycotic.PowerShell.Authentication.Session [f2f869c](https://github.com/thycotic-ps/thycotic.secretserver/commit/f2f869c4e6adabe79844c8571f3d8ea40c3a60fb)
* removing about files from local module, only maintaining online going forward [cc6a162](https://github.com/thycotic-ps/thycotic.secretserver/commit/cc6a16286caee0fa1e155472bf00cf9641114121)
* TssSession - migrate to C# Class and renamed [4369e1a](https://github.com/thycotic-ps/thycotic.secretserver/commit/4369e1a7cd0fa6dca2c082c0f8191128bbe45560)
* TssSecret - migrate and update --> Thycotic.PowerShell.Secrets.Secret [a170898](https://github.com/thycotic-ps/thycotic.secretserver/commit/a17089838607a0f4e83e80ffc3bcfb6152eecf1e)
* SecretItems - rename class to Items [20a0997](https://github.com/thycotic-ps/thycotic.secretserver/commit/20a0997f20214844e36ade97294a3e6a281bb950)
* TssSecretSummary - migrate and update --> Thycotic.PowerShell.Secrets.Summary [cb5eebd](https://github.com/thycotic-ps/thycotic.secretserver/commit/cb5eebd3f65d18d4d0cb2df603e466c368681b55)
* TssSecretSummary - migrate and update --> SummaryExtendedField [f42827c](https://github.com/thycotic-ps/thycotic.secretserver/commit/f42827c2e5223a91fe79b92313a7ae5f43c015c3)
* TssSecretDetailSettings - migrate and update --> Thycotic.PowerShell.Secrets.DetailSettings [c56b75b](https://github.com/thycotic-ps/thycotic.secretserver/commit/c56b75b498b88de98055901209697361a1d9329f)
* TssSecretDetailState - migrate and update --> Thycotic.PowerShell.Secrets.DetailState [4f85ad2](https://github.com/thycotic-ps/thycotic.secretserver/commit/4f85ad2564f38dd28e41d88d7ac487c93e6ab606)
* TssSecretLookup - migrate and update --> Thycotic.PowerShell.Secrets.Lookup [b954371](https://github.com/thycotic-ps/thycotic.secretserver/commit/b95437193a001ef897130bef4c4d035c6e221571)
* TssSecretHeartbeatStatus - migrate and update --> Thycotic.PowerShell.Secrets.HeartbeatStatus [a9f3117](https://github.com/thycotic-ps/thycotic.secretserver/commit/a9f3117b20bb8187a5e71f5a767e2148946398a1)
* TssSecretPasswordStatus - migrate and update --> Thycotic.PowerShell.Secrets.PasswordStatus [ea6e1b9](https://github.com/thycotic-ps/thycotic.secretserver/commit/ea6e1b95bfb70579cd438bb14921f55d4aa2431a)

### Bug Fixes

* Set-SecretRpcPrivilege - correct links in cbh [a0288bb](https://github.com/thycotic-ps/thycotic.secretserver/commit/a0288bbd98de0f468dc709aac8cc604342ab432e)
* invoke-SecretGeneratePassword - fix doc error [5b2c270](https://github.com/thycotic-ps/thycotic.secretserver/commit/5b2c27049ad0b88fa6d0bb2e1a544db13fe56e87)
* Update-FolderPermission - correct logging [50a1df6](https://github.com/thycotic-ps/thycotic.secretserver/commit/50a1df6a628dbf71b02f7faeb0073f2a43196d2d)
* Logging cmdlets - default format to "log" [4551208](https://github.com/thycotic-ps/thycotic.secretserver/commit/45512080b7b459d4b24c0aaff573aa0d6ad780a8)
* WriteLog cmdlet - correct LogFormat parameter [2214e9a](https://github.com/thycotic-ps/thycotic.secretserver/commit/2214e9a08c6d3597621278d153b32c34133ef347)
* WriteLog cmdlet - Correct message output log format [4773c6d](https://github.com/thycotic-ps/thycotic.secretserver/commit/4773c6d898cbfad9d852dd5d6b21a4b14e08d5c6)
* Stop-Log - correct code comment [f707419](https://github.com/thycotic-ps/thycotic.secretserver/commit/f707419112a27f8a3ce784120cb34e713bcfc278)
* Search-Metadata - update version check, only for 10.9.64 and above [8ac59f8](https://github.com/thycotic-ps/thycotic.secretserver/commit/8ac59f8142476047638e659b752ca930c1240d5a)

### New Stuff

* Search-Metadata - new command [e25470a](https://github.com/thycotic-ps/thycotic.secretserver/commit/e25470a692ca5104045c1425d910bea6608b0327)
* Write-Log - add pipe support for LogFilePath, LogFormat, MessageType, and Message [12b78bd](https://github.com/thycotic-ps/thycotic.secretserver/commit/12b78bdb5033e6be95cd1216897710426efec15c)
* Search-Metadata - convert to C# class [c5d819a](https://github.com/thycotic-ps/thycotic.secretserver/commit/c5d819a36488526ea8bd8f7412ca4931a810ddf3)
* Update-SecretRdpLauncherSetting - new command [24d9ad7](https://github.com/thycotic-ps/thycotic.secretserver/commit/24d9ad77edeed79504c892302399d266f02e0cbf)

### General Updates

* TssSecretTemplateField - add IsList property [7e7e3c8](https://github.com/thycotic-ps/thycotic.secretserver/commit/7e7e3c8b8884c66d6ca83bfc22e8305950f1e281)
* Client SDK - move binaries to new folder, update path references [37f0a9d](https://github.com/thycotic-ps/thycotic.secretserver/commit/37f0a9d49e033c510d4857789ce535f6693ad04f)
* TssSession parameter - update help description [c7bd03d](https://github.com/thycotic-ps/thycotic.secretserver/commit/c7bd03d627ed52d86b4b79eecfe208599c010f35)
* Version commands - update format of param block [8de8248](https://github.com/thycotic-ps/thycotic.secretserver/commit/8de8248ad73e43d82d389cecaee77edbcfdc4eae)
* doc update - compatibility add metadata cmd [a9dd53b](https://github.com/thycotic-ps/thycotic.secretserver/commit/a9dd53be6ea04bfca5dc3767b41559cc6d00f271)
* module - Format ps1xml file update to new class names [588c721](https://github.com/thycotic-ps/thycotic.secretserver/commit/588c72160d515d3299e215a19cbef3e67e36d437)
* Set-SecretField - correct syntax issue in ex 1 [f288b94](https://github.com/thycotic-ps/thycotic.secretserver/commit/f288b944db1350a4b0eb5ab35a93e36b9b8d2a7d)

### Tests

* tests - adjust for new build process [bea6605](https://github.com/thycotic-ps/thycotic.secretserver/commit/bea660540a34dd29f099de704e2e89cdee3e8f97)

## [0.47.0] -- 2021-07-03

### Breaking Changes

* None

### Bug Fixes

* Get-Secret - fix piping support [bf750b5](https://github.com/thycotic-ps/thycotic.secretserver/commit/bf750b54e471f26803615812c70aa1a1e8ed6774)
* Get-SecretField - fix pipeline support [d711b45](https://github.com/thycotic-ps/thycotic.secretserver/commit/d711b45612f4d222cb143f529d1f9fa7b0ae2986)
* Add-SecretTemplateField - add piping support [23c35aa](https://github.com/thycotic-ps/thycotic.secretserver/commit/23c35aa15b4a290f9bd4adefd98f5dd52e99c43e)
* Get-SecretAttachment - fixed output issue if file attachment is not found [c6fda6f](https://github.com/thycotic-ps/thycotic.secretserver/commit/c6fda6fdf34935a7abc243e3fa1c41ef04608da4)

### New Stuff

* Open-Secret - add piping support [9a5b009](https://github.com/thycotic-ps/thycotic.secretserver/commit/9a5b009edb0911e23146eee392f438b29d9a7718)
* Find-Report - new command fixes [#3](https://github.com/thycotic-ps/thycotic.secretserver/issues/3) [9087705](https://github.com/thycotic-ps/thycotic.secretserver/commit/90877053adbe121291082f5884ab3776ea468a71)
* Search-Report - new command fixes [#4](https://github.com/thycotic-ps/thycotic.secretserver/issues/4) [3b36868](https://github.com/thycotic-ps/thycotic.secretserver/commit/3b36868b61b680203e2b28410b48009fb9ed46ec)
* Remove-Report - new command fixes [#42](https://github.com/thycotic-ps/thycotic.secretserver/issues/42) [2cf097d](https://github.com/thycotic-ps/thycotic.secretserver/commit/2cf097da80b3969151aec50eb77b3d3682fcbce3)
* Get-ReportParameter - new command fixes [#21](https://github.com/thycotic-ps/thycotic.secretserver/issues/21) [f37b1b7](https://github.com/thycotic-ps/thycotic.secretserver/commit/f37b1b77a7d0f5955883d8c3dcd5c2e38d91e486)
* Invoke-Report - new command for executing reports [59cd835](https://github.com/thycotic-ps/thycotic.secretserver/commit/59cd835751727648f21fa45117d71820fe6e2429)
* Export-Report - new command [cc0b187](https://github.com/thycotic-ps/thycotic.secretserver/commit/cc0b1878e09e7caf4a849186377313e186d53cc0)

### General Updates

* Logging - Write-Log perf improvement [60c7388](https://github.com/thycotic-ps/thycotic.secretserver/commit/60c73886d5d36e24ef87445d4e0693774acbabb5)
* check version - change to verbose instead of warning [d4ff2ad](https://github.com/thycotic-ps/thycotic.secretserver/commit/d4ff2add84b25e00e842a94e36cd26d71efd36f2)
* Close-Secret - removing unused variable [2191587](https://github.com/thycotic-ps/thycotic.secretserver/commit/2191587a8bee50168380fed1dee5d855a315ab01)
* Invoke-SecretGeneratePassword - remove pipeline support command does not use it [c5f8441](https://github.com/thycotic-ps/thycotic.secretserver/commit/c5f844101c811416f79e7c89d3f3e71549e3177d)

### Tests

* None

## [0.46.2] -- 2021-06-30

### Breaking Changes

* None

### Bug Fixes

* Set-SecretField - fixes [#198](https://github.com/thycotic-ps/thycotic.secretserver/issues/198) [964b464](https://github.com/thycotic-ps/thycotic.secretserver/commit/964b464b1382c10001421fca9df752dfdedf18ca)
* Invoke-SecretGeneratePassword - correct var references [20dee0d](https://github.com/thycotic-ps/thycotic.secretserver/commit/20dee0d9aee56ff3bb3b9f6eaef9c3f9bbaa558b)

### New Stuff

* None

### General Updates

* None

### Tests

* None

## [0.46.1] -- 2021-06-30

### Breaking Changes

* None

### Bug Fixes

* Get-SecretField - fix bug on failed API call If endpoint returns hard exception, further API calls were breaking. [43b9551](https://github.com/thycotic-ps/thycotic.secretserver/commit/43b9551deaeb914c34da00d34924d9e4691286b8)

### New Stuff

* None

### General Updates

* None

### Tests

* None

## [0.46.0] -- 2021-06-28

### Breaking Changes

* None

### Bug Fixes

* None

### New Stuff

* TssSession - add CheckTokenTtl Check if token expiration is within timespan unit [5d0fb78](https://github.com/thycotic-ps/thycotic.secretserver/commit/5d0fb7878dbcafe2b5eb50dcc56fce67a95ffc0d)
* New-Group - new command [0da7494](https://github.com/thycotic-ps/thycotic.secretserver/commit/0da7494d4629d0fd6b806adddc18ab1a4159aa75)

### General Updates

* UL - remove unused variable [6e423aa](https://github.com/thycotic-ps/thycotic.secretserver/commit/6e423aa2af37894784c217efb576c0bee4fde4ef)
* Add-FolderPermission - correct CBH example [7e6dcea](https://github.com/thycotic-ps/thycotic.secretserver/commit/7e6dcea0840e77e5ec58229b9e081f8dd8b6c34e)

### Tests

* None

## [0.45.0] -- 2021-06-25

### Breaking Changes

* New-FolderPermissions - Add force, breaks behavior Default endpoint breaks inheritance, command prevents it from doing that unless Force is provided [948747b](https://github.com/thycotic-ps/thycotic.secretserver/commit/948747b7f46638067d2ca42f466aa6edfc72f834)
* New-SecretPermission - Add DomainName, Username, GroupName, Force Removed UserId and GroupId. Command now won't break inheritance unless -Force is provided. [bbad8c7](https://github.com/thycotic-ps/thycotic.secretserver/commit/bbad8c79b792042e19f1ab36a195da62739f2425)

### Bug Fixes

* Test-SdkClient - fix logic issue on matching [680bc2a](https://github.com/thycotic-ps/thycotic.secretserver/commit/680bc2a0436d7c356adff3896ec58883cfd3d9bc)

### New Stuff

* New-FolderPermission - add support for multiple Folder IDs [acf6bd3](https://github.com/thycotic-ps/thycotic.secretserver/commit/acf6bd32cf7f912086fe4734bb1c390b70048e37)
* Add-FolderPermission - new command to bulk add permissions based on name (user/group) [da1c74d](https://github.com/thycotic-ps/thycotic.secretserver/commit/da1c74d0b3501bdd0da8fc895f1331bae19ca4c0)
* Add-SecretPermission - new command [bcefc77](https://github.com/thycotic-ps/thycotic.secretserver/commit/bcefc77bfacfef1d62948796a6b3484785198d8f)

### General Updates

* New-FolderPermission - add doc examples [7646fff](https://github.com/thycotic-ps/thycotic.secretserver/commit/7646fffcb698903f8604600d4562706acc9ac954)

### Tests

* None

## [0.44.0] -- 2021-06-24

### Breaking Changes

* None

### Bug Fixes

* Update-FolderPermission - correct output type [2318c8f](https://github.com/thycotic-ps/thycotic.secretserver/commit/2318c8f85aa012581b52a95d9dc552ecd0bb99ae)
* Update-Secret - fix issue where input was not processed properly [b37b699](https://github.com/thycotic-ps/thycotic.secretserver/commit/b37b699b56914836b9f50b30d60b309eaa8daf04)
* Get-SecretField - fix issue where raw file content not returned IRM returns the content as an object, switched to use IWR to get raw content [3fdfaeb](https://github.com/thycotic-ps/thycotic.secretserver/commit/3fdfaebd9e39aa8c5b158abc0b6bf46decebb36f)

### New Stuff

* Get-TssSecretAccessRequestSecret - new command [d89394b](https://github.com/thycotic-ps/thycotic.secretserver/commit/d89394b109e2418f5e6d48b0947b2c0e55558c08)

### General Updates

* Set-SecretField - correct output messages [b09f147](https://github.com/thycotic-ps/thycotic.secretserver/commit/b09f147ff53f27e0bc130de0fed3cce71983af41)
* Set-SecretField - parameter sets for file to make more clear Removed requirement that Value is only a string, added check to cover [5c3606b](https://github.com/thycotic-ps/thycotic.secretserver/commit/5c3606be95526b2a807ae0a9d41b70a96d58b58c)
* Set-SecretField - format warning output [0df9c42](https://github.com/thycotic-ps/thycotic.secretserver/commit/0df9c42cc92128ac97d56a6321f1b313f9e252b5)

### Tests

* None

## [0.43.1] -- 2021-06-20

### Breaking Changes

* None

### Bug Fixes

* None

### New Stuff

* None

### General Updates

* module - correcting cbh online links [28ea95b](https://github.com/thycotic-ps/thycotic.secretserver/commit/28ea95b2d56236e9dfdb3ead3cc52692cfb76d56)

### Tests

* None

## [0.43.0] -- 2021-06-20

### Breaking Changes

* Get-SecretAudit - changed to sort desc Since Audit data can be large, have it sort on server-side to spit latest out first [30ff8a0](https://github.com/thycotic-ps/thycotic.secretserver/commit/30ff8a0e6076e483861c81de1b60c6019c7b7ae3)
* Update-FolderPermission - rename from Set-FolderPermission [f562dea](https://github.com/thycotic-ps/thycotic.secretserver/commit/f562deaa20031e5710c5dcc479ce3e776ed9e401)

### Bug Fixes

* Search-SecretTemplate - IncludeInactive fix param type [73d5217](https://github.com/thycotic-ps/thycotic.secretserver/commit/73d52175df5047bb4ce5a475bfc14058580de093)
* Get-Secret - fixe issue with IncludeInactive Parameter was not applied to the API call being made [19f3920](https://github.com/thycotic-ps/thycotic.secretserver/commit/19f3920334e9e5237696efe674c01c1708acaccf)
* Update-Folder - fix issue with warning string [3243797](https://github.com/thycotic-ps/thycotic.secretserver/commit/3243797a76283679f6bd312256dae4fee468fa7f)
* Test-SdkClient - adjust return false logic [8d0cd20](https://github.com/thycotic-ps/thycotic.secretserver/commit/8d0cd20801e04232901dcecf6213099b499e6311)

### New Stuff

* Update-User - new command [b88ba6d](https://github.com/thycotic-ps/thycotic.secretserver/commit/b88ba6d69c78c29f285c679d984ddf2093246491)
* Set-SecretTemplate - new command [0dbee8e](https://github.com/thycotic-ps/thycotic.secretserver/commit/0dbee8e33387c25b1d153002920f8af0a101ead2)
* Get-SecretAccessRequestOption - new command [de809d1](https://github.com/thycotic-ps/thycotic.secretserver/commit/de809d171d5a0515c151a6c6fbc17db48bdbdea2)
* Get-Site - new command [a7e390e](https://github.com/thycotic-ps/thycotic.secretserver/commit/a7e390ee4dd61472c7500cfb3591eff019ffc858)
* Remove-UserPii - new command [535eb9d](https://github.com/thycotic-ps/thycotic.secretserver/commit/535eb9d640c4f4f1b93791f2e3f64be0bef669be)
* Search-WorkflowTemplate - new command [7a510d0](https://github.com/thycotic-ps/thycotic.secretserver/commit/7a510d0f05e4abd346d2a58d4cdacfae46ad6746)
* Get-Secret - add GetFileFields method see about_ file for TssSecret for more details [8b838af](https://github.com/thycotic-ps/thycotic.secretserver/commit/8b838af584c75e85002e8e2171fba5b3e6d906b3)
* Update-Folder - new command [a4a59a8](https://github.com/thycotic-ps/thycotic.secretserver/commit/a4a59a8625fefe0bc313344ae2f713e765daeb36)
* Test-SdkClient - new command Lets you test the config and checks to match SS host [9074773](https://github.com/thycotic-ps/thycotic.secretserver/commit/9074773df69582caf7f1319fbd7020dc1b992a30)
* Get-SecreTemplate - additional parameter alias SecretTemplateId [27e0afa](https://github.com/thycotic-ps/thycotic.secretserver/commit/27e0afaf29c56a81193a782fb0f3e2508a48260a)
* Get-SecretTemplateFolder - new command Allows to get list of Allowed Templates configured on a Folder [a9ba308](https://github.com/thycotic-ps/thycotic.secretserver/commit/a9ba308d14d45f829e3bbd1bf770e04e64407559)
* TssSecretTemplate - add GetField method For use with Update-SecretTemplateField [e5c0cbb](https://github.com/thycotic-ps/thycotic.secretserver/commit/e5c0cbb05b4d523372b52009d6693a5675a79742)
* Update-SecretTemplateField - new command [548426b](https://github.com/thycotic-ps/thycotic.secretserver/commit/548426b63d62035d16a0f18e93ea61447671e00f)

### General Updates

* module - correcting casing on username [c4b1b34](https://github.com/thycotic-ps/thycotic.secretserver/commit/c4b1b34eb0c3904f14d8c47eaac0fc627896fe3b)
* Invoke-RestApi - removing unneeded code [fce5152](https://github.com/thycotic-ps/thycotic.secretserver/commit/fce5152bbcbdb33509116c38e9336f689b2ba918)
* Update-Folder - add type output [d42a3ce](https://github.com/thycotic-ps/thycotic.secretserver/commit/d42a3ce267690c1c46d1f28fc6c117ce71132f6c)
* Search-TssFolder - PermissionRequired param allow multiple Can filter on multiple permissions for a folder [876ba0f](https://github.com/thycotic-ps/thycotic.secretserver/commit/876ba0f49bf0419e3757ed590000c5dc2783e530)
* doc site rebuild [f7e9b2d](https://github.com/thycotic-ps/thycotic.secretserver/commit/f7e9b2dd6c87aa119502319b6c0018d21acdcca2)
* module - rename folder for doc changes [cbb4aa7](https://github.com/thycotic-ps/thycotic.secretserver/commit/cbb4aa766ca8c2aa942f57afada32338e5e20f27)
* Add-GroupMember - update based on test [6cf9310](https://github.com/thycotic-ps/thycotic.secretserver/commit/6cf9310836cc26239ad405eae80ae94bfba0765b)
* Get-GroupRole - update based on test [9232481](https://github.com/thycotic-ps/thycotic.secretserver/commit/92324815b2793f9c776feb015e64051726dc53f4)
* Test-SecretState - set output to full type name [4cb9f28](https://github.com/thycotic-ps/thycotic.secretserver/commit/4cb9f2841e86548855af1e91b84d3fe6b66944b7)

### Tests

* Test-SdkClient - test update [0758191](https://github.com/thycotic-ps/thycotic.secretserver/commit/075819159e7421979ed50e4b808815069eebccd1)
* Module file integrity test - update performance [83d2c19](https://github.com/thycotic-ps/thycotic.secretserver/commit/83d2c19c4a4c31746a6e70f1f43cd4128328c969)
* Get-GroupUser - fix test [4144f87](https://github.com/thycotic-ps/thycotic.secretserver/commit/4144f87a15cb20cb13d61461c57ca4d569f39a21)

## [0.42.0] -- 2021-06-04

### Breaking Changes

* None

### Bug Fixes

* Add-GroupMember - correct warning message [34cb4d5](https://github.com/thycotic-ps/thycotic.secretserver/commit/34cb4d51b341d4ae4a8f43349c5d391b38cb1739)
* Remove-Folder - correct warning message [ade562f](https://github.com/thycotic-ps/thycotic.secretserver/commit/ade562f03fa4ec8dd73874acaa201ac615f550e5)
* Set-FolderPermission - correct warning message [4f65edd](https://github.com/thycotic-ps/thycotic.secretserver/commit/4f65edd9c619ac56be90c269025db5f1864e8af8)

### New Stuff

* Get-FolderState -allows to see actions allowed [a4091c1](https://github.com/thycotic-ps/thycotic.secretserver/commit/a4091c1106b6cf3447654a4e609b96964d53d459)
* Test-FolderAction - test for allowed action [946c35e](https://github.com/thycotic-ps/thycotic.secretserver/commit/946c35e6f86a99b2f8127ebe0a54ae2d591f4476)
* Test-SecretAction - allows test for given action on secret [4c21a43](https://github.com/thycotic-ps/thycotic.secretserver/commit/4c21a434f5d9b1d71ac9e8cf304c01b52adba931)
* Test-SecretState - test for a given state on a secret [942452d](https://github.com/thycotic-ps/thycotic.secretserver/commit/942452d0724c5b26e85e0ae4f26098c04c32a061)

### General Updates

* None

### Tests

* None

## [0.41.0] -- 2021-06-03

### Breaking Changes

* Protect-Secret - Renamed to Close-Secret Removed output as well. Will return no output if successful. [ab774f0](https://github.com/thycotic-ps/thycotic.secretserver/commit/ab774f089854722c0bece134b9454226f1b3c100)

### Bug Fixes

* module - fix issue with import on unix OS [c73537f](https://github.com/thycotic-ps/thycotic.secretserver/commit/c73537f9c8e879c73b78ae853f9f1859373a459a)
* Disable/Enable Unlimited Admin - correcting validation [2c32f8f](https://github.com/thycotic-ps/thycotic.secretserver/commit/2c32f8fab3fd7a62eb07d8c9b6919b516b8041d3)
* Search-SecretPermission - correct issue from test [3af9359](https://github.com/thycotic-ps/thycotic.secretserver/commit/3af93592fd550814103013adcdfb3c0d8fe742fb)
* Update-GroupMember - corrected error Functions as expected now [b9fda39](https://github.com/thycotic-ps/thycotic.secretserver/commit/b9fda39cd850ef49f295ad1766bcdbd6fb84e7a9)

### New Stuff

* Search-SecretPermission - closes [#186](https://github.com/thycotic-ps/thycotic.secretserver/issues/186) [7731fab](https://github.com/thycotic-ps/thycotic.secretserver/commit/7731fabecea4f4d8e2008bb12469d3b929fa8f81)
* Remove-SecretPermission - closes [#187](https://github.com/thycotic-ps/thycotic.secretserver/issues/187) [d020a14](https://github.com/thycotic-ps/thycotic.secretserver/commit/d020a14844cc558b4ff2cd32cd78f1add43fb76e)
* Update-SecretPermission - closes #189 [2cf1104](https://github.com/thycotic-ps/thycotic.secretserver/commit/2cf1104999b4762801c1282faf7e2e164ac26bb4)
* Search-SecretPolicy [b980a3d](https://github.com/thycotic-ps/thycotic.secretserver/commit/b980a3d7c47cade3820d09cd253054a5ba7c6dfa)
* Search-SecretHook - closes [#191](https://github.com/thycotic-ps/thycotic.secretserver/issues/191) [fb3a7ed](https://github.com/thycotic-ps/thycotic.secretserver/commit/fb3a7eded3da0f46bdc74756afff0f75e30e5e89)
* Open-Secret - allows for checking out a secret [dc23ab3](https://github.com/thycotic-ps/thycotic.secretserver/commit/dc23ab3ea48aaef7e3a91ff4e4cc3f06445ab4df)
* Get-SecretHook - closes [#192](https://github.com/thycotic-ps/thycotic.secretserver/issues/192) [87f6a6e](https://github.com/thycotic-ps/thycotic.secretserver/commit/87f6a6e1a89d8288184d6506ecd4ceb5d7fdccfb)
* Update-GroupMember - usage pending correction of endpoint There is a null exception being thrown in 10.9.64 for the endpoint. [b4f63b4](https://github.com/thycotic-ps/thycotic.secretserver/commit/b4f63b4b312602e8b1694f8120c703c84e4a64ef)
* Remove-SecretHook - closes [#193](https://github.com/thycotic-ps/thycotic.secretserver/issues/193) [8d2aa75](https://github.com/thycotic-ps/thycotic.secretserver/commit/8d2aa7537f2fe892f6a3924a4f5f91040680f666)
* Update-SecretHook - closes [#194](https://github.com/thycotic-ps/thycotic.secretserver/issues/194) [235ee5f](https://github.com/thycotic-ps/thycotic.secretserver/commit/235ee5f31ecd1b162ab11b3ef9032c2f2693928f)
* Get-SecretHookStub - closes [#195](https://github.com/thycotic-ps/thycotic.secretserver/issues/195) [34d4683](https://github.com/thycotic-ps/thycotic.secretserver/commit/34d468346025f2a7f21ca11c9771c544330575a0)
* Get-Script command [56891f7](https://github.com/thycotic-ps/thycotic.secretserver/commit/56891f7e75d5e1d242b23b325ca65e2e1a3434bc)
* Search-Script command [efc8d24](https://github.com/thycotic-ps/thycotic.secretserver/commit/efc8d24f37ddd0a6e1fda8c47f7bfebeabaf2ffa)
* Get-Script - enhanced TssScript class/output Additional child classes, Added method GetScriptParams() [712e528](https://github.com/thycotic-ps/thycotic.secretserver/commit/712e5283d0896587ac888cdf5ef9082357714ff9)
* Get-SecretHookStub - add Name, PrePostOption and EventAction params [68beed4](https://github.com/thycotic-ps/thycotic.secretserver/commit/68beed4222d788d78690e7a408449e73dceca4f6)
* New-SecretHook - closes [#196](https://github.com/thycotic-ps/thycotic.secretserver/issues/196) [942ae0a](https://github.com/thycotic-ps/thycotic.secretserver/commit/942ae0a7efe2dd1d0a3a053b3b4bf5c716a9185e)
* New-SecretDependency - closes [#182](https://github.com/thycotic-ps/thycotic.secretserver/issues/182) [26b343f](https://github.com/thycotic-ps/thycotic.secretserver/commit/26b343f5cec5882fda9f1c96eafe9ed8118b0e0c)

### General Updates

* adding devcontainer [cfa85ad](https://github.com/thycotic-ps/thycotic.secretserver/commit/cfa85ad9fd59e7988beb8a1ce829f0ea7a8a73ca)
* module - Add aliases Checkout-Secret / CheckIn-Secret Compliments use of the Open/Close-Secret [5ee8224](https://github.com/thycotic-ps/thycotic.secretserver/commit/5ee822490fc08f506f5c6d2b7f61f04433c2e6fc)
* Module - implemented [Nullable[datetime]] Handles endpoints that return null for datetime properties [20a41e7](https://github.com/thycotic-ps/thycotic.secretserver/commit/20a41e7a079f28d7b6c60960797409c944686237)
* module - correct version check [458e56f](https://github.com/thycotic-ps/thycotic.secretserver/commit/458e56fc2f307e628321679d81823e6d0f903d38)
* Add-GroupMember - correct help info [1ffbb64](https://github.com/thycotic-ps/thycotic.secretserver/commit/1ffbb6496ab2db85255f638ccae59c3900758d0f)
* module - correcting variable reference [ce12ea8](https://github.com/thycotic-ps/thycotic.secretserver/commit/ce12ea87c778f726ed305f69572b86e1c20b4fc2)
* snippet update [9dd1fad](https://github.com/thycotic-ps/thycotic.secretserver/commit/9dd1fad4c24df400deddcd18356c2968adb17fb0)
* Get-SecretHookStub - correcting output object [49e5512](https://github.com/thycotic-ps/thycotic.secretserver/commit/49e5512a0ef0cc4789760368cd89408e5c0f2f09)
* Get-User - updating verbose output [10e7862](https://github.com/thycotic-ps/thycotic.secretserver/commit/10e7862735f3ee99355bd9315ee25ce4baf49e25)
* Update-SecretHook - updated PrePostOption help [e089053](https://github.com/thycotic-ps/thycotic.secretserver/commit/e0890537ccb599ec618c4ab9256745b61dc1b411)

### Tests

* Get-SecretHook correct test filename [74444c7](https://github.com/thycotic-ps/thycotic.secretserver/commit/74444c712e75aa95576556244e2cc75e4c3562a7)
* Update-SecretHook - update tests Added params parameters [e16cbc3](https://github.com/thycotic-ps/thycotic.secretserver/commit/e16cbc337cdb2f7ec4adcb001a53f29715431daf)

## [0.40.0] -- 2021-05-28

### Breaking Changes

* None

### Bug Fixes

* TssUserSummary - add property TwoFactorMethod [880672b](https://github.com/thycotic-ps/thycotic.secretserver/commit/880672b71f3a7643cd2f17ef00bb11f5b54fe263)

### New Stuff

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

### General Updates

* Search-SecretDependency - adjust output [c2aa919](https://github.com/thycotic-ps/thycotic.secretserver/commit/c2aa919f127f3998494aeec94ad016aac082d9af)
* Get-SecretDependencyTemplate - rename class type [855ab2e](https://github.com/thycotic-ps/thycotic.secretserver/commit/855ab2ee64ec5cfc3fc8b477cdba6b919d13657c)
* module - correct command alias reference and examples [95f4656](https://github.com/thycotic-ps/thycotic.secretserver/commit/95f46566dd37787d56281e50f369c0374452c6ea)
* module - correct links in manifest [a898187](https://github.com/thycotic-ps/thycotic.secretserver/commit/a89818717c4ea7ddbea2d436fff95afe72f7365d)
* Set-Secret - formatting [4795cf3](https://github.com/thycotic-ps/thycotic.secretserver/commit/4795cf36922213aeb69a72eb585070706ca037f3)
* Module - adjust how version check is performed This removes calling the version endpoint in every command, only called once now. [fb317ba](https://github.com/thycotic-ps/thycotic.secretserver/commit/fb317ba0a2aa697027535552a535e2e299a6f96c)
* module - applying formatting changes [71fa1f7](https://github.com/thycotic-ps/thycotic.secretserver/commit/71fa1f714dfbf8ce203d607f8d966921f775ef0e)
* Get-UserAudit - fixing warning message [99dd43e](https://github.com/thycotic-ps/thycotic.secretserver/commit/99dd43e3465888efe7feb3383e1d62cb93364aa5)

### Tests

* Tests - renaming [9cb0867](https://github.com/thycotic-ps/thycotic.secretserver/commit/9cb0867e456c2efcc20d6af8f279516d8374ca48)
* Tests - Removed integration and unit testing [ddc96c2](https://github.com/thycotic-ps/thycotic.secretserver/commit/ddc96c22efe387038bc3414875cd2e06f2109d3f)

## [0.39.0] -- 2021-05-07

### Breaking Changes

* None

### Bug Fixes

* None

### New Stuff

* Search-SecretDependency - fixes [#173](https://github.com/thycotic-ps/thycotic.secretserver/issues/173) [3ad064b](https://github.com/thycotic-ps/thycotic.secretserver/commit/3ad064b39b00b5d55a58164ff7c61144c9a43ee1)
* New-SecretDependencyGroup - fixes [#178](https://github.com/thycotic-ps/thycotic.secretserver/issues/178) [26a2c80](https://github.com/thycotic-ps/thycotic.secretserver/commit/26a2c80e10db2e3ce9e6569a47b81902b4fa8c58)
* Get-Secret - Add Path support fixes #174 [e3fcf0e](https://github.com/thycotic-ps/thycotic.secretserver/commit/e3fcf0e1f6b35a9f7c418a1be75212d1dbb317c1)
* Get-SecretDependency - fixes [#175](https://github.com/thycotic-ps/thycotic.secretserver/issues/175) [2be0039](https://github.com/thycotic-ps/thycotic.secretserver/commit/2be00397e07036d60225eaae5e32dc9a24758688)
* Get-SecretDependencyGroup - fixes [#177](https://github.com/thycotic-ps/thycotic.secretserver/issues/177) [e4740a5](https://github.com/thycotic-ps/thycotic.secretserver/commit/e4740a563b43e621549e3d348502e00a461d22c9)
* Remove-SecretDependency - closes #176 [c6173c8](https://github.com/thycotic-ps/thycotic.secretserver/commit/c6173c81f50d60bbcd0b936e8fa9adff0c4a089c)
* Set-SecretField - support files via value If content of file provided via value, include FileName [94f0654](https://github.com/thycotic-ps/thycotic.secretserver/commit/94f0654b4c8a26279be080a3d0b63e622114d062)
* Start-SecretDependency - fixes [#179](https://github.com/thycotic-ps/thycotic.secretserver/issues/179) [2565995](https://github.com/thycotic-ps/thycotic.secretserver/commit/25659956127826ef05db97e948dcaf4ec0caf559)
* Get-SecretDependencyRunStatus - fixes [#180](https://github.com/thycotic-ps/thycotic.secretserver/issues/180) [c062da2](https://github.com/thycotic-ps/thycotic.secretserver/commit/c062da298a7c30bdb3acf8a2305f51033bbbddee)

### General Updates

* module - add format for dependency classes [51ae103](https://github.com/thycotic-ps/thycotic.secretserver/commit/51ae10387ef6d2d0e9add56f05ede7ccfd7c0288)
* Get-SecretDependency - adding param description [bf97d39](https://github.com/thycotic-ps/thycotic.secretserver/commit/bf97d39e883c9702e7bbfb2e0440cb21f070707f)
* Start-SecretHeartbeat - correcting help links [e4d9c95](https://github.com/thycotic-ps/thycotic.secretserver/commit/e4d9c95a82fc0d168ba28d80e3c7539949162ae4)

### Tests

* None

## [0.38.0] -- 2021-04-28

### Breaking Changes

* None

### Bug Fixes

* New-TssUser - add examples fixes [#160](https://github.com/thycotic-ps/thycotic.secretserver/issues/160) [400ac84](https://github.com/thycotic-ps/thycotic.secretserver/commit/400ac84cfc307b63e0f4e412c5d52a8878031172)
* Update-TssSecret - fix issue with uri found during testing [b7e96f1](https://github.com/thycotic-ps/thycotic.secretserver/commit/b7e96f17e897d102ef2cb01ea9fb63c7caaf4f68)
* Docs - correcting links for CBH [8347663](https://github.com/thycotic-ps/thycotic.secretserver/commit/834766305ae6c82de43c11a1008286e098647cba)

### New Functions

* Update-TssSecret - fixes [#169](https://github.com/thycotic-ps/thycotic.secretserver/issues/169) [3587c61](https://github.com/thycotic-ps/thycotic.secretserver/commit/3587c61b2f991da8fc518d33cfeca0c20dfb5437)
* Search-TssRpcPasswordType - closes [#149](https://github.com/thycotic-ps/thycotic.secretserver/issues/149) [5f99639](https://github.com/thycotic-ps/thycotic.secretserver/commit/5f996396084919fb68417fc27df664d60fc6d8ff)
* Get-RpcPasswordType - closes [#34](https://github.com/thycotic-ps/thycotic.secretserver/issues/34) [dacde70](https://github.com/thycotic-ps/thycotic.secretserver/commit/dacde70e070c998e83a7461b864450298676635e)
* Get-GroupMember - closes [#55](https://github.com/thycotic-ps/thycotic.secretserver/issues/55) [66a203d](https://github.com/thycotic-ps/thycotic.secretserver/commit/66a203d8d46be56059890e9e0d2eba978b7e13f8)
* Secret Template - Added New-SecretTemplateField and Add-SecretTemplateField [7fdd18b](https://github.com/thycotic-ps/thycotic.secretserver/commit/7fdd18bab2fc68b2e4793db8b56ebbc487da1fb6)

### General Updates

* docs - commands page - remove links to spec file New API doc site: https://thycotic-ps.github.io/secretserver-apidoc [3f16fee](https://github.com/thycotic-ps/thycotic.secretserver/commit/3f16fee904af3b2eb13312c8564967a09a6e2a23)
* Set-SecretField - Correcting examples [6f89ba2](https://github.com/thycotic-ps/thycotic.secretserver/commit/6f89ba298f3f8efe2a391a245307cbc5a83c593b)

### Tests

* None

## [0.37.0] -- 2021-04-16

### Breaking Changes

* Removed Folder and User stub commands [c5037c4](https://github.com/thycotic-ps/thycotic.secretserver/commit/c5037c449325c205f64b76c3348d523fc7af6c03)

### Bug Fixes

* None

### New

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

### General Updates

* Search-TssFolder - perf improvement [233744d](https://github.com/thycotic-ps/thycotic.secretserver/commit/233744d745179a3da8c2ce47866dcc40bdecd9f6)
* docs - add New-TssUser help [738584d](https://github.com/thycotic-ps/thycotic.secretserver/commit/738584d38b8077d0606b4e61028899e72b0ebe73)
* docs - removed command old command help [371d137](https://github.com/thycotic-ps/thycotic.secretserver/commit/371d137f96c50adfaf0251b278f8382ddc49dcab)
* Get-SecretRpcAssociated - adjust output to support Set function [e6e3523](https://github.com/thycotic-ps/thycotic.secretserver/commit/e6e3523c93625819c37f48a5ab1b3a0c96442611)
* Protect-Secret - remove unused code [2922f21](https://github.com/thycotic-ps/thycotic.secretserver/commit/2922f211fb668f3729c3b587c98db1f6399dead0)
* Enable-SecretEmail - correct link in cbh [4ded087](https://github.com/thycotic-ps/thycotic.secretserver/commit/4ded087c6b5b2cd8da771fae4ef1210af7b9b0f4)
* functions - correcting parameter help [a1fc3df](https://github.com/thycotic-ps/thycotic.secretserver/commit/a1fc3dfedc2b0d04da96cf252a8cc7710eb1a8f9)

### Tests

* None

## [0.36.0] -- 2021-04-05

### Breaking Changes

* None

### Bug Fixes

* New-TssFolder - fixes [#145](https://github.com/thycotic-ps/thycotic.secretserver/issues/145) [ba94c17](https://github.com/thycotic-ps/thycotic.secretserver/commit/ba94c17255c9494999e2d55998e31d5289df2489)
* docs - Working With content [#82](https://github.com/thycotic-ps/thycotic.secretserver/issues/82) [650ae1e](https://github.com/thycotic-ps/thycotic.secretserver/commit/650ae1e39c3bf26883307e216ef1362c2e6272a5)
* Set-TssSecret - fixes [#147](https://github.com/thycotic-ps/thycotic.secretserver/issues/147) [a9dd25f](https://github.com/thycotic-ps/thycotic.secretserver/commit/a9dd25f2d87ff0138692ab2dee018d7e8c6e33ae)
* Get-TssConfiguration - fixes [#148](https://github.com/thycotic-ps/thycotic.secretserver/issues/148) April release adds additional properties [8c5d6a8](https://github.com/thycotic-ps/thycotic.secretserver/commit/8c5d6a8d5c9ec94ee64af3f1fcd18f9ae6cfe568)

### New Functions

* Revoke-Secret - fixes [#134](https://github.com/thycotic-ps/thycotic.secretserver/issues/134) [64d14e2](https://github.com/thycotic-ps/thycotic.secretserver/commit/64d14e223a687275b5e886a48ceeefd610fb05fa)
* Start-SecretHeartbeat - fixes [#135](https://github.com/thycotic-ps/thycotic.secretserver/issues/135) [34dfd79](https://github.com/thycotic-ps/thycotic.secretserver/commit/34dfd79af17c8e210787ab2737e7eb6f7c0e7693)
* Set-SecretExpiration - fixes [#136](https://github.com/thycotic-ps/thycotic.secretserver/issues/136) [48db3bc](https://github.com/thycotic-ps/thycotic.secretserver/commit/48db3bc35dee031ce098e41dbad04df976379c32)
* Set-SecretRpcPrivileged - fixes [#139](https://github.com/thycotic-ps/thycotic.secretserver/issues/139) [91a4851](https://github.com/thycotic-ps/thycotic.secretserver/commit/91a485165a40bc662cca70d779d8d04479f06247)
* Search-DistributedEngineSite - fixes [#146](https://github.com/thycotic-ps/thycotic.secretserver/issues/146) [c9165c9](https://github.com/thycotic-ps/thycotic.secretserver/commit/c9165c9c6ac2f17720cf5735681884848899216a)

### General Updates

* Set-SecretExpiration - update variable name [941b21c](https://github.com/thycotic-ps/thycotic.secretserver/commit/941b21c14d0453624dcc7812d64bc169ebad5344)

### Tests

* Tests - added assert calls [4dbe545](https://github.com/thycotic-ps/thycotic.secretserver/commit/4dbe5455fbcdfb92ecb5b92d2b893ed52fc3d147)

## [0.35.0] -- 2021-04-04

### Breaking Changes

* TssSecret - GetCredential method update closes [#133](https://github.com/thycotic-ps/thycotic.secretserver/issues/133) [92e8a1e](https://github.com/thycotic-ps/thycotic.secretserver/commit/92e8a1ed56c9b4fb730bef16286ec32551632808)
* New-TssFolder - Revert param changes [78638ed](https://github.com/thycotic-ps/thycotic.secretserver/commit/78638ed6b0ea05af977f99ba8caa65ce86eecc07)

### Bug Fixes

* module - correct import closes [#132](https://github.com/thycotic-ps/thycotic.secretserver/issues/132) [47ec7ce](https://github.com/thycotic-ps/thycotic.secretserver/commit/47ec7cebc86dc6be4594d7395b88198c37f973fc)
* Find-User - fixed output issue identified by test [3bee92b](https://github.com/thycotic-ps/thycotic.secretserver/commit/3bee92bfdd93be5d4ce4171247603b4933bd719b)
* CheckVersion - correct invoke param [57dfb6d](https://github.com/thycotic-ps/thycotic.secretserver/commit/57dfb6d03b1b450c874aa18ec7e913e7f77c3dad)
* Set-TssSecret - fixing bug identified during testing Removing Template param as this is not usable on the endpoint [9fc876b](https://github.com/thycotic-ps/thycotic.secretserver/commit/9fc876bc2beed32cf14fa7b1501c50f9dd65984f)
* CheckVersion - correct invoke param [57dfb6d](https://github.com/thycotic-ps/thycotic.secretserver/commit/57dfb6d03b1b450c874aa18ec7e913e7f77c3dad)
* TssSession - Correct issue found on SessionRefresh [83d6533](https://github.com/thycotic-ps/thycotic.secretserver/commit/83d65333a248154194dda25ab85743ece0aeb77c)

### New Functions

* Get-TssUserStub - closes #97 [5650be7](https://github.com/thycotic-ps/thycotic.secretserver/commit/5650be73b21ce742d0a7e00d59bec4838462b3f8)
* Set-TssSecretSecurity - fixes #137 [9e3b22e](https://github.com/thycotic-ps/thycotic.secretserver/commit/9e3b22e331bec9a967782b86147173d21c8e0b78)

### General Updates

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

### Tests

* snippet - test added assert call [18685b6](https://github.com/thycotic-ps/thycotic.secretserver/commit/18685b6dbafd1ff7705e9c8a2719a04e19dda5c9)
* tests - add random string generator [8e1500d](https://github.com/thycotic-ps/thycotic.secretserver/commit/8e1500da6bdaf666ffc7555ada38a92e6107bb2e)
* Tests - Users tests reworked [738098f](https://github.com/thycotic-ps/thycotic.secretserver/commit/738098f5a24753dd458ae754b5c7a58d1a533cec)
* tests - removed test data (no longer needed) [f68c137](https://github.com/thycotic-ps/thycotic.secretserver/commit/f68c137e95be82807f526720c3d309301667ab6e)
* Secret Tests - reworked [ee188be](https://github.com/thycotic-ps/thycotic.secretserver/commit/ee188beab18438a64cb46e5f98ef2356341c6546)
* Set-Secret - Tests rework Still work to do [cb39262](https://github.com/thycotic-ps/thycotic.secretserver/commit/cb39262473c730c9a6b4debc4560a1a60553ecb1)

## [0.34.0] -- 2021-03-25

### Breaking Changes

* Set-TssSecret - remove email setting params closes [#125](https://github.com/thycotic-ps/thycotic.secretserver/issues/125) [6e98382](https://github.com/thycotic-ps/thycotic.secretserver/commit/6e9838232eae4ce68de5e576e1db2601393d72fc)
* Set-TssSecret - remove field params closes [#118](https://github.com/thycotic-ps/thycotic.secretserver/issues/118) [8a90145](https://github.com/thycotic-ps/thycotic.secretserver/commit/8a901450880a0acc93cb7142d2f57eb50c4cdabb)
* Get-TssFolderPermissionStub - removed function [0194279](https://github.com/thycotic-ps/thycotic.secretserver/commit/01942795ddb43f6464d8265742fc2933de2347eb)

### New Functions

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

### General Updates

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

### Bug Fixes

* Find-TssSecret - closes #111 [4f9d2c7](https://github.com/thycotic-ps/thycotic.secretserver/commit/4f9d2c7be971dcb1506cc569832712ef4e513336)
* TssSecret - SetFieldValue - closes [#124](https://github.com/thycotic-ps/thycotic.secretserver/issues/124) [aa75be9](https://github.com/thycotic-ps/thycotic.secretserver/commit/aa75be996d863c3d2c498ba38fd8cee704d4b8e9)
* Invoke-TssRestApi - correct issue with processing [1688c7d](https://github.com/thycotic-ps/thycotic.secretserver/commit/1688c7d25a68e5c1a6896c36c0961775b41127f4)

### Tests

* Folder Permission - Tests - update mocking [457fe7d](https://github.com/thycotic-ps/thycotic.secretserver/commit/457fe7ddd3c25756ffecd2190f02e0bd736852cf)
* New-TssFolderPermission Test - remove unused code [09981c8](https://github.com/thycotic-ps/thycotic.secretserver/commit/09981c88d775ef199d506295a2f10447db60a0a7)
* New-TssFolder - removed integration test ToDo - replace with mocking [3ac59d8](https://github.com/thycotic-ps/thycotic.secretserver/commit/3ac59d8574a1f17d6612b86431d94123e7eb2aef)

## [0.33.1] -- 2021-03-05

### Added

* None

### Changed

* `New-TssSession` adjust logic on URL for OAuth2 request [#109](https://github.com/thycotic-ps/thycotic.secretserver/issues/109) [f4061e5](https://github.com/thycotic-ps/thycotic.secretserver/commit/f4061e57906e127465f1c949e51eaec77da527a4)

## [0.33.0] -- 2021-03-05

### Added

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
