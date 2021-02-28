---
title: "Thycotic.SecretServer + API Command Reference"
permalink: /commands/
excerpt: "Command Reference"
last_modified_at: 2021-02-11T00:00:00-00:00
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

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[POST /oauth2/token][POST /oauth2/token] | [New-TssSession][New-TssSession]

## Secrets

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[POST /secrets][POST /secrets] | [New-TssSecret][New-TssSecret]
[GET /secrets/stubs][GET /secrets/stubs] | [Get-TssSecretStub][Get-TssSecretStub]
[DELETE /secrets/{id}][DELETE /secrets/{id}] | [Remove-TssSecret][Remove-TssSecret]
[GET /secrets/lookup][GET /secrets/lookup] | [Find-TssSecret][Find-TssSecret]
[GET /secrets/lookup/{id}][GET /secrets/lookup/{id}] | [Find-TssSecret][Find-TssSecret]
[GET /secrets/{id}][GET /secrets/{id}] | [Get-TssSecret][Get-TssSecret][Get-TssSecret]
[POST /secrets/{id}/restricted][POST /secrets/{id}/restricted] | [Get-TssSecret][Get-TssSecret]
[GET /secrets/{id}/fields/{slug}][GET /secrets/{id}/fields/{slug}] | [Get-TssSecretField][Get-TssSecretField]
[GET /secrets][GET /secrets] | [Search-TssSecret][Search-TssSecret]
[PUT /secrets/{id}/fields/{slug}][PUT /secrets/{id}/fields/{slug}] | [Set-TssSecret][Set-TssSecret]
[PATCH /secrets/{id}/email][PATCH /secrets/{id}/email] | [Set-TssSecret][Set-TssSecret]
[PATCH /secrets/{id}/general][PATCH /secrets/{id}/general] | [Set-TssSecret][Set-TssSecret]
[POST /secrets/{id}/stop-password-change][POST /secrets/{id}/stop-password-change] | [Stop-TssSecretPasswordChange][Stop-TssSecretPasswordChange]

## Secrets-Templates

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /secret-templates/{id}][GET /secret-templates/{id}] | [Get-TssSecretTemplate][Get-TssSecretTemplate]

## Folders

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /folders/{id}][GET /folders/{id}] |[Get-TssFolder][Get-TssFolder]
[GET /folders][GET /folders] | [Search-TssFolder][Search-TssFolder]
[GET /folders/lookup][GET /folders/lookup] | [Find-TssFolder][Find-TssFolder]
[POST /folders][POST /folders] | [New-TssFolder][New-TssFolder]
[DELETE /folders/{id}][DELETE /folders/{id}] | [Remove-TssFolder][Remove-TssFolder]
[GET /folders/stub][GET /folders/stub] | [Get-TssFolderStub][Get-TssFolderStub]
[GET /folders/{id}/audit][GET /folders/{id}/audit] | [Get-TssFolderAuditSummary][Get-TssFolderAuditSummary]
[PATCH /folders/{id}][PATCH /folders/{id}] | [Set-TssFolder][Set-TssFolder]
[GET /folders/{id}/audit][GET /folders/{id}/audit] | [Get-TssFolderAudit][Get-TssFolderAudit]
[DELETE /folders/{id}/templates/{templateId}][DELETE /folders/{id}/templates/{templateId}] | [Remove-TssFolderTemplate][Remove-TssFolderTemplate]

## Folder-Permissions

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /folder-permissions/stub][GET /folder-permissions/stub] | [Get-TssFolderPermissionsStub][Get-TssFolderPermissionsStub]
[GET /folder-permissions][GET /folder-permissions] | [Search-TssFolderPermission][Search-TssFolderPermission]
[GET /folder-permissions/{id}][GET /folder-permissions{id}] | [Get-TssFolderPermission][Get-TssFolderPermission]
[PUT /folder-permissions/{id}][PUT /folder-permissions{id}] | [Set-TssFolderPermission][Set-TssFolderPermission]
[POST /folder-permissions/{id}][POST /folder-permissions{id}] | [New-TssFolderPermission][New-TssFolderPermission]
[DELETE /folder-permissions/{id}][DELETE /folder-permissions{id}] | [Remove-TssFolderPermission][Remove-TssFolderPermission]

## Reports

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /reports/{id}][GET /reports/{id}] | [Get-TssReport][Get-TssReport]
[GET /reports/categories/{reportCategoryId}][GET /reports/categories/{reportCategoryId}] | [Get-TssReportCategory][Get-TssReportCategory]
[GET /reports/categories][GET /reports/categories] | [Get-TssReportCategory][Get-TssReportCategory]
[POST /reports][POST /reports] | [New-TssReport][New-TssReport]
[DELETE /reports/categories/{reportCategoryId}][DELETE /reports/categories/{reportCategoryId}] | [Remove-TssReportCategory][Remove-TssReportCategory]
[GET /reports/schedules][GET /reports/schedules] | [Search-TssReportSchedule][Search-TssReportSchedule]

## Groups

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /groups][GET /groups] | [Search-TssGroup][Search-TssGroup]

## General

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /version][GET /version] | [Get-TssVersion][Get-TssVersion]

[New-TssSession]:/thycotic.secretserver/commands/New-TssSession
[Get-TssFolder]:/thycotic.secretserver/commands/Get-TssFolder
[Search-TssGroup]:/thycotic.secretserver/commands/Search-TssGroup
[Get-TssReport]:/thycotic.secretserver/commands/Get-TssReport
[Get-TssReportCategory]:/thycotic.secretserver/commands/Get-TssReportCategory
[New-TssReport]:/thycotic.secretserver/commands/New-TssReport
[Remove-TssReportCategory]:/thycotic.secretserver/commands/Remove-TssReportCategory
[Search-TssReportSchedule]:/thycotic.secretserver/commands/Search-TssReportSchedule
[Remove-TssSecret]:/thycotic.secretserver/commands/Remove-TssSecret
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
[Get-TssFolderAudit]:/thycotic.secretserver/commands/Get-TssFolderAudit
[Set-TssFolder]:/thycotic.secretserver/commands/Set-TssFolder
[Get-TssFolderAudit]:/thycotic.secretserver/commands/Get-TssFolderAudit
[Remove-TssFolderTemplate]:/thycotic.secretserver/commands/Remove-TssFolderTemplate
[Get-TssFolderPermissionsStub]:/thycotic.secretserver/commands/Get-TssFolderPermissionsStub
[Get-TssFolderAuditSummary]:/thycotic.secretserver/commands/Get-TssFolderAuditSummary
[Get-TssFolderPermission]:/thycotic.secretserver/commands/Get-TssFolderPermission
[Search-TssFolderPermission]:/thycotic.secretserver/commands/Search-TssFolderPermission
[Set-TssFolderPermission]:/thycotic.secretserver/commands/Set-TssFolderPermission
[Remove-TssFolderPermission]:/thycotic.secretserver/commands/Remove-TssFolderPermission
[New-TssFolderPermission]:/thycotic.secretserver/commands/New-TssFolderPermission

[POST /folder-permissions/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder-permissions-post
[DELETE /folder-permissions/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder-permissions--id--delete
[GET /folder-permissions/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder-permissions--id--get
[GET /folder-permissions/]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder-permissions-get
[GET /folder-permissions/stub]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder-permissions-stub-get
[DELETE /folders/{id}/templates/{templateId}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders--id--templates--templateId--delete
[GET /folders/{id}/audit]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders--id--audit-get
[PATCH /folders/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder--id--patch
[DELETE /folders/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders--id--delete
[GET /folders/stub]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders-stub-get
[POST /folders]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders-post
[GET /folders/lookup]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders-lookup-get
[GET /folders]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders-get
[GET /folders/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders--id--get
[POST /oauth2/token]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/OAuth/#path--oauth2-token
[GET /groups]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--groups-get
[GET /reports/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports--id--get
[GET /reports/categories/{reportCategoryId}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports-categories--reportCategoryId--get
[GET /reports/categories]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports-categories-get
[POST /reports]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports-post
[DELETE /reports/categories/{reportCategoryId}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports-categories--reportCategoryId--delete
[GET /reports/schedules]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--reports-schedules-get
[DELETE /secrets/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--delete
[GET /secrets/lookup]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-lookup-get
[GET /secrets/lookup/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-lookup--id--get
[GET /secrets/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--get
[POST /secrets/{id}/restricted]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--restricted-post
[GET /secrets/{id}/fields/{slug}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--fields--slug--get
[GET /secrets]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-get
[PUT /secrets/{id}/fields/{slug}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--fields--slug--put
[PATCH /secrets/{id}/email]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--email-patch
[PATCH /secrets/{id}/general]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--general-patch
[GET /secret-templates/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secret-templates--id--get
[GET /secrets/{id}/stop-password-change]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--stop-password-change-post
[GET /version]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--version-get
[GET /secrets/stubs]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-stub-get
[POST /secrets]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-post
[POST /secrets/{id}/stop-password-change]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--stop-password-change-post