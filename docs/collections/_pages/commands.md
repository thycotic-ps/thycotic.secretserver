---
title: "Thycotic.SecretServer + API Command Reference"
permalink: /commands/
excerpt: "Command Reference"
last_modified_at: 2021-03-03T00:00:00-00:00
toc: false
layout: single-mod
classes: wide
author_profile: false
share: false
sidebar:
  nav: "commands"
---

The table below lists the API endpoints matched up to the function that directly calls them.

Some API endpoints are combined into a single Thycotic.SecretServer commands.
{: .notice--warning}

A Thycotic.SecretServer command may not appear in the below list because it is not explicitly developed against an API endpoint.
{: .notice--info}

## Authentication

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[POST /oauth2/token] | [New-TssSession]

## Secrets

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[POST /secrets] | [New-TssSecret]
[GET /secrets/stubs] | [Get-TssSecretStub]
[DELETE /secrets/{id}] | [Remove-TssSecret]
[GET /secrets/lookup] | [Find-TssSecret]
[GET /secrets/lookup/{id}] | [Find-TssSecret]
[GET /secrets/{id}] | [Get-TssSecret]
[GET /secrets/{id}/audits] | [Get-TssSecretAudit]
[POST /secrets/{id}/restricted] | [Get-TssSecret]
[GET /secrets/{id}/fields/{slug}] | [Get-TssSecretField]
[GET /secrets/{id}/state] | [Get-TssSecretState]
[GET /secrets] | [Search-TssSecret]
[PUT /secrets/{id}/fields/{slug}] | [Set-TssSecret]
[PATCH /secrets/{id}/email] | [Set-TssSecret]
[PATCH /secrets/{id}/general] | [Set-TssSecret]
[POST /secrets/{id}/stop-password-change] | [Stop-TssSecretChangePassword]
`POST /internals/secret-detail/{id}/change-password-now` | [Start-TssSecretChangePassword]
`GET /internals/secret-detail/{id}/password-status` | [Get-TssSecretPasswordStatus]
`GET /internals/secret-detail/{id}/generate-password` | [Invoke-TssSecretGeneratePassword]
`POST /internals/secret-detail/{id}/validate-password` | [Invoke-TssSecretGeneratePassword]

## Secret Access Requests

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[POST /secret-access-requests/secrets/{id}/view-comment] | [Set-TssSecret]

## Secrets Templates

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /secret-templates/{id}] | [Get-TssSecretTemplate]

## Folders

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /folders/{id}]                           |[Get-TssFolder]
[GET /folders]                                | [Search-TssFolder]
[GET /folders/lookup]                         | [Find-TssFolder]
[POST /folders]                               | [New-TssFolder]
[DELETE /folders/{id}]                        | [Remove-TssFolder]
[GET /folders/stub]                           | [Get-TssFolderStub]
[PATCH /folders/{id}]                         | [Set-TssFolder]
[GET /folders/{id}/audit]                     | [Get-TssFolderAudit]
[DELETE /folders/{id}/templates/{templateId}] | [Remove-TssFolderTemplate]

## Folder Permissions

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /folder-permissions/stub]    | [Get-TssFolderPermissionsStub]
[GET /folder-permissions]         | [Search-TssFolderPermission]
[GET /folder-permissions/{id}]    | [Get-TssFolderPermission]
[PUT /folder-permissions/{id}]    | [Set-TssFolderPermission]
[POST /folder-permissions/{id}]   | [New-TssFolderPermission]
[DELETE /folder-permissions/{id}] | [Remove-TssFolderPermission]

## Reports

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /reports/{id}]                             | [Get-TssReport]
[GET /reports/categories/{reportCategoryId}]    | [Get-TssReportCategory]
[GET /reports/categories]                       | [Get-TssReportCategory]
[POST /reports]                                 | [New-TssReport]
[DELETE /reports/categories/{reportCategoryId}] | [Remove-TssReportCategory]
[GET /reports/schedules]                        | [Search-TssReportSchedule]

## Groups

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /groups] | [Search-TssGroup]

## Roles

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /roles] | [Search-TssRole]

## Users

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /users/{id}] | [Get-TssUser]
[GET /users/{id}/roles] | [Get-TssUserRole]
[GET /users/{userId}/roles-assigned] | [Get-TssUserRoleAssigned]
[GET /users] | [Search-TssUser]
[GET /users/lookup] | [Find-TssUser]
[GET /users/current] | [Show-TssCurrentUser]

## Directory Services

**API Endpoint** | **Thycotic.SecretServer Command** |
---------------- | --------------------------------- |
[GET /directory-services/domains] | [Search-TssDirectoryServiceDomain]

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
[Stop-TssSecretChangePassword]:/thycotic.secretserver/commands/Stop-TssSecretChangePassword
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
[Search-TssRole]:/thycotic.secretserver/commands/Search-TssRole
[Get-TssUserRole]:/thycotic.secretserver/commands/Get-TssUserRole
[Get-TssUserRoleAssigned]:/thycotic.secretserver/commands/Get-TssUserRoleAssigned
[Start-TssSecretChangePassword]:/thycotic.secretserver/commands/Start-TssSecretChangePassword
[Get-TssSecretPasswordStatus]:/thycotic.secretserver/commands/Get-TssSecretPasswordStatus
[Invoke-TssSecretGeneratePassword]:/thycotic.secretserver/commands/Invoke-TssSecretGeneratePassword
[Search-TssUser]:/thycotic.secretserver/commands/Search-TssUser
[Find-TssUser]:/thycotic.secretserver/commands/Find-TssUser
[Search-TssDirectoryServiceDomain]:/thycotic.secretserver/commands/Search-TssDirectoryServiceDomain
[Show-TssCurrentUser]:/thycotic.secretserver/commands/Show-TssCurrentUser
[Get-TssUser]:/thycotic.secretserver/commands/Get-TssUser
[Get-TssSecretAudit]:/thycotic.secretserver/commands/Get-TssSecretAudit
[Get-TssSecretState]:/thycotic.secretserver/commands/Get-TssSecretState

[GET /secrets/{id}/state]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--state-get
[GET /secrets/{id}/audits]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--audits-get
[GET /users/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--users--id--get
[GET /users/current]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--users-current-get
[GET /directory-services/domains]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--directory-services-domains-get
[GET /users/lookup]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--users-lookup-get
[GET /users]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--users-get
[GET /users/{userId}/roles-assigned]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--users--userId--roles-assigned-get
[POST /secret-access-requests/secrets/{id}/view-comment]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secret-access-requests-secrets--id--view-comment-post
[GET /users/{id}/roles]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--users--id--roles-get
[GET /roles]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--roles-get
[PUT /folder-permissions/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder-permissions--id--put
[POST /folder-permissions/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder-permissions-post
[DELETE /folder-permissions/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder-permissions--id--delete
[GET /folder-permissions/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder-permissions--id--get
[GET /folder-permissions]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder-permissions-get
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