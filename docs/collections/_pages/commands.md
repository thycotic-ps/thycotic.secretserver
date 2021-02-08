---
title: "Thycotic.SecretServer + API Command Reference"
permalink: /commands/
excerpt: "Command Reference"
last_modified_at: 2021-02-10T00:00:00-00:00
toc: false
layout: single-mod
classes: wide
author_profile: false
share: false
sidebar:
  nav: "commands"
---

The table below is a lists for the API endpoints, against links to the Thycotic.SecretServer command where the API endpoint is exposed within the module.

Some API endpoints are combined into single Thycotic.SecretServer commands.
{: .notice--warning}
A Thycotic.SecretServer command may not appear in the below list due to it not being explicitly developed against an API endpoint.
{: .notice--info}

## Authentication

**API Endpoint** | **Method** | **Thycotic.SecretServer Command** |
---------------- | ---------- | --------------------------------- |
[/oauth2/token][/oauth2/token] | POST | [New-TssSession][New-TssSession]

## Secrets

**API Endpoint** | **Method** | **Thycotic.SecretServer Command** |
---------------- | ---------- | --------------------------------- |
[/secrets][/secrets] | PUT | [New-TssSecret][New-TssSecret]
[/secrets/stubs][/secrets/stubs] | GET | [Get-TssSecretStub][Get-TssSecretStub]
[/secrets/{id}][/secrets/{id}] | DELETE | [Disable-TssSecret][Disable-TssSecret]
[/secrets/lookup][/secrets/lookup] | GET | [Find-TssSecret][Find-TssSecret]
[/secrets/lookup/{id}][/secrets/lookup/{id}] | GET | [Find-TssSecret][Find-TssSecret]
[/secrets/{id}][/secrets/{id}] | GET | [Get-TssSecret][Get-TssSecret][Get-TssSecret]
[/secrets/{id}/restricted][/secrets/{id}/restricted] | POST | [Get-TssSecret][Get-TssSecret]
[/secrets/{id}/fields/{slug}][/secrets/{id}/fields/{slug}] | GET | [Get-TssSecretField][Get-TssSecretField]
[/secrets][/secrets] | GET | [Search-TssSecret][Search-TssSecret]
[/secrets/{id}/fields/{slug}][/secrets/{id}/fields/{slug}] | PUT | [Set-TssSecret][Set-TssSecret]
[/secrets/{id}/email][/secrets/{id}/email] | PATCH | [Set-TssSecret][Set-TssSecret]
[/secrets/{id}/general][/secrets/{id}/general] | PATCH | [Set-TssSecret][Set-TssSecret]
[/secrets/{id}/stop-password-change][/secrets/{id}/stop-password-change] | POST | [Stop-TssSecretPasswordChange][Stop-TssSecretPasswordChange]

## Secrets-Templates

**API Endpoint** | **Method** | **Thycotic.SecretServer Command** |
---------------- | ---------- | --------------------------------- |
[/secret-templates/{id}][/secret-templates/{id}] | GET | [Get-TssSecretTemplate][Get-TssSecretTemplate]

## Folders

**API Endpoint** | **Method** | **Thycotic.SecretServer Command** |
---------------- | ---------- | --------------------------------- |
[/folders/{id}][/folders/{id}] | GET | [Get-TssFolder][Get-TssFolder]
[/folders][/folders] | GET | [Search-TssFolder][Search-TssFolder]
[/folders/lookup][/folders/lookup] | GET | [Find-TssFolder][Find-TssFolder]
[/folders][/folders] | POST | [New-TssFolder][New-TssFolder]
[/folders/{id}][/folders/{id}] | DELETE | [Remove-TssFolder][Remove-TssFolder]
[/folders/stub][/folders/stub] | GET | [Get-TssFolderStub][Get-TssFolderStub]

## Reports

**API Endpoint** | **Method** | **Thycotic.SecretServer Command** |
---------------- | ---------- | --------------------------------- |
[/reports/{id}][/reports/{id}] | GET | [Get-TssReport][Get-TssReport]
[/reports/categories/{reportCategoryId}][/reports/categories/{reportCategoryId}] | GET | [Get-TssReportCategory][Get-TssReportCategory]
[/reports/categories][/reports/categories] | GET | [Get-TssReportCategory][Get-TssReportCategory]
[/reports][/reports] | POST | [New-TssReport][New-TssReport]
[/reports/categories/{reportCategoryId}][/reports/categories/{reportCategoryId}] | DELETE | [Remove-TssReportCategory][Remove-TssReportCategory]
[/reports/schedules][/reports/schedules] | GET | [Search-TssReportSchedule][Search-TssReportSchedule]

## Groups

**API Endpoint** | **Method** | **Thycotic.SecretServer Command** |
---------------- | ---------- | --------------------------------- |
[/groups][/groups] | GET | [Search-TssGroup][Search-TssGroup]

## General

**API Endpoint** | **Method** | **Thycotic.SecretServer Command** |
---------------- | ---------- | --------------------------------- |
[/version][/version] | GET | [Get-TssVersion][Get-TssVersion]

[New-TssSession]:/thycotic.secretserver/commands/New-TssSession
[Get-TssFolder]:/thycotic.secretserver/commands/Get-TssFolder
[Search-TssGroup]:/thycotic.secretserver/commands/Search-TssGroup
[Get-TssReport]:/thycotic.secretserver/commands/Get-TssReport
[Get-TssReportCategory]:/thycotic.secretserver/commands/Get-TssReportCategory
[New-TssReport]:/thycotic.secretserver/commands/New-TssReport
[Remove-TssReportCategory]:/thycotic.secretserver/commands/Remove-TssReportCategory
[Search-TssReportSchedule]:/thycotic.secretserver/commands/Search-TssReportSchedule
[Disable-TssSecret]:/thycotic.secretserver/commands/Disable-TssSecret
[Find-TssSecret]:/thycotic.secretserver/commands/Find-TssSecret
[Get-TssSecret]:/thycotic.secretserver/commands/Get-TssSecret
[Get-TssSecretField]:/thycotic.secretserver/commands/Get-TssSecretField
[Search-TssSecret]:/thycotic.secretserver/commands/Search-TssSecret
[Set-TssSecret]:/thycotic.secretserver/commands/Set-TssSecret
[Get-TssSecretTemplate]:/thycotic.secretserver/commands/Get-TssSecretTemplate
[Stop-TssSecretPasswordChange]:/thycotic.secretserver/commands/Stop-TssSecretPasswordChange
[Get-TssVersion]:/thycotic.secretserver/commands/Get-TssVersion
[New-TssSecret]:/thycotic.secretserver/commands/New-TssSecret
[Get-TssSecretStub]:/thycotic.secretserver/commands/Get-TssSecretStub
[Search-TssFolder]:/thycotic.secretserver/commands/Search-TssFolder
[Find-TssFolder]:/thycotic.secretserver/commands/Find-TssFolder
[New-TssFolder]:/thycotic.secretserver/commands/New-TssFolder
[Get-TssFolderStub]:/thycotic.secretserver/commands/Get-TssFolderStub
[Remove-TssFolder]:/thycotic.secretserver/commands/Remove-TssFolder

[/folders/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders--id--delete
[/folders/stub]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders-stub-get
[/folders]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders-post
[/folders/lookup]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders-lookup-get
[/folders]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders-get
[/secrets/stubs]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-stub-get
[/secrets]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-post
[/oauth2/token]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/OAuth/#path--oauth2-token
[/folders/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders--id--get
[/groups]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--groups-get
[/reports/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports--id--get
[/reports/categories/{reportCategoryId}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports-categories--reportCategoryId--get
[/reports/categories]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports-categories-get
[/reports]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports-post
[/reports/categories/{reportCategoryId}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports-categories--reportCategoryId--delete
[/reports/schedules]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports-schedules-get
[/secrets/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--delete
[/secrets/lookup]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-lookup-get
[/secrets/lookup/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-lookup--id--get
[/secrets/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--get
[/secrets/{id}/restricted]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--restricted-post
[/secrets/{id}/fields/{slug}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--fields--slug--get
[/secrets]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-get
[/secrets/{id}/fields/{slug}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--fields--slug--put
[/secrets/{id}/email]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--email-patch
[/secrets/{id}/general]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--general-patch
[/secret-templates/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secret-templates--id--get
[/secrets/{id}/stop-password-change]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--stop-password-change-post
[/version]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--version-get