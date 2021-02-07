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

[New-TssSession]:/commands/New-TssSession
[Get-TssFolder]:/commands/Get-TssFolder
[Search-TssGroup]:/commands/Search-TssGroup
[Get-TssReport]:/commands/Get-TssReport
[Get-TssReportCategory]:/commands/Get-TssReportCategory
[New-TssReport]:/commands/New-TssReport
[Remove-TssReportCategory]:/commands/Remove-TssReportCategory
[Search-TssReportSchedule]:/commands/Search-TssReportSchedule
[Disable-TssSecret]:/commands/Disable-TssSecret
[Find-TssSecret]:/commands/Find-TssSecret
[Get-TssSecret]:/commands/Get-TssSecret
[Get-TssSecretField]:/commands/Get-TssSecretField
[Search-TssSecret]:/commands/Search-TssSecret
[Set-TssSecret]:/commands/Set-TssSecret
[Get-TssSecretTemplate]:/commands/Get-TssSecretTemplate
[Stop-TssSecretPasswordChange]:/commands/Stop-TssSecretPasswordChange
[Get-TssVersion]:/commands/Get-TssVersion
[New-TssSecret]:/commands/New-TssSecret
[Get-TssSecretStub]:/commands/Get-TssSecretStub

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