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

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[New-TssSession] | [POST /oauth2/token]

## Directory Services

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Search-TssDirectoryServiceDomain] | [GET /directory-services/domains]

## Distributed Engines

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Search-TssDistributedEngineSite] | [GET /distributed-engine/sites]

## Folders

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Find-TssFolder] | [GET /folders/lookup]
[Get-TssFolder] | [GET /folders/{id}]
[Get-TssFolderAudit] | [GET /folders/{id}/audit]
[New-TssFolder] | [POST /folders]
[Remove-TssFolder] | [DELETE /folders/{id}]
[Remove-TssFolderTemplate] | [DELETE /folders/{id}/templates/{templateId}]
[Search-TssFolder] | [GET /folders]
[Set-TssFolder] | [PATCH /folders/{id}]

## Folder Permissions

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Get-TssFolderPermission] | [GET /folder-permissions/{id}]
[New-TssFolderPermission] | [POST /folder-permissions/{id}]
[Remove-TssFolderPermission] | [DELETE /folder-permissions/{id}]
[Search-TssFolderPermission] | [GET /folder-permissions]
[Set-TssFolderPermission] | [PUT /folder-permissions/{id}]

## General

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Get-TssVersion] | [GET /version]

## Groups

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Search-TssGroup] | [GET /groups]

## Reports

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Get-TssReport] | [GET /reports/{id}]
[Get-TssReportCategory] | [GET /reports/categories/{reportCategoryId}]
[Get-TssReportCategory] | [GET /reports/categories]
[New-TssReport] | [POST /reports]
[Remove-TssReportCategory] | [DELETE /reports/categories/{reportCategoryId}]
[Search-TssReportSchedule] | [GET /reports/schedules]

## Roles

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Search-TssRole] | [GET /roles]

## RPC

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Get-TssSecretRpcAssociated] | `/internals/secret-detail/{id}/rpc`

## Secrets

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Disable-TssSecretCheckout] | [PATCH /secrets/{id}/security-checkout]
[Disable-TssSecretEmail] | [PATCH /secrets/{id}/email]
[Enable-TssSecretCheckout] | [PATCH /secrets/{id}/security-checkout]
[Enable-TssSecretEmail] | [PATCH /secrets/{id}/email]
[Find-TssSecret] | [GET /secrets/lookup]
[Find-TssSecret] | [GET /secrets/lookup/{id}]
[Get-TssSecret] | [GET /secrets/{id}]
[Get-TssSecret] | [POST /secrets/{id}/restricted]
[Get-TssSecretAudit] | [GET /secrets/{id}/audits]
[Get-TssSecretField] | [POST /secrets/{id}/restricted/fields/{slug}]
[Get-TssSecretField] | [GET /secrets/{id}/fields/{slug}]
[Get-TssSecretPasswordStatus] | `GET /internals/secret-detail/{id}/password-status`
[Get-TssSecretSetting] | [GET /secrets/{id}/settings]
[Get-TssSecretState] | [GET /secrets/{id}/state]
[Get-TssSecretStub] | [GET /secrets/stub]
[Get-TssSecretSummary] | [GET /secrets/{id}/summary]
[Invoke-TssSecretGeneratePassword] | `GET /internals/secret-detail/{id}/generate-password`
[Invoke-TssSecretGeneratePassword] | `POST /internals/secret-detail/{id}/validate-password`
[New-TssSecret] | [POST /secrets]
[Protect-TssSecret] | [POST /secrets/{id}/check-in]
[Remove-TssSecret] | [DELETE /secrets/{id}]
[Restore-TssSecret] | [PUT /secrets/{id}/undelete]
[Revoke-TssSecret] | [POST /secrets/{id}/expire]
[Search-TssSecret] | [GET /secrets]
[Set-TssSecret] | [PATCH /secrets/{id}/general]
[Set-TssSecret] | [POST /secrets/{id}/check-in]
[Set-TssSecret] | [PUT /secrets/{id}]
[Set-TssSecretExpiration] | [PUT /secrets/{id}/expiration]
[Set-TssSecretField] | [PUT /secrets/{id}/fields/{slug}]
[Set-TssSecretRpcPrivileged] | `PUT /internals/secret-detail/{id}/rpc`
[Set-TssSecretSecurity] | [PATCH /secrets/{id}/security-general]
[Start-TssSecretChangePassword] | `POST /internals/secret-detail/{id}/change-password-now`
[Stop-TssSecretChangePassword] | [POST /secrets/{id}/stop-password-change]

## Secret Access Requests

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Set-TssSecret] | [POST /secret-access-requests/secrets/{id}/view-comment]

## Secrets Templates

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Get-TssSecretTemplate] | [GET /secret-templates/{id}]
[Search-TssSecretTemplate] | [GET /secret-templates]

## Users

**Command** | **API Endpoint** |
---------------- | --------------------------------- |
[Find-TssUser] | [GET /users/lookup]
[Get-TssUser] | [GET /users/{id}]
[Get-TssUserAudit] | [GET /users/{userId}/audit]
[Get-TssUserRole] | [GET /users/{id}/roles]
[Get-TssUserRoleAssigned] | [GET /users/{userId}/roles-assigned]
[New-TssUser] | [POST /users]
[Search-TssUser] | [GET /users]
[Show-TssCurrentUser] | [GET /users/current]

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
[Remove-TssFolder]:/thycotic.secretserver/commands/Remove-TssFolder
[Get-TssFolderAudit]:/thycotic.secretserver/commands/Get-TssFolderAudit
[Set-TssFolder]:/thycotic.secretserver/commands/Set-TssFolder
[Get-TssFolderAudit]:/thycotic.secretserver/commands/Get-TssFolderAudit
[Remove-TssFolderTemplate]:/thycotic.secretserver/commands/Remove-TssFolderTemplate
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
[Disable-TssSecretCheckout]:/thycotic.secretserver/commands/Disable-TssSecretCheckout
[Disable-TssSecretEmail]:/thycotic.secretserver/commands/Disable-TssSecretEmail
[Enable-TssSecretCheckout]:/thycotic.secretserver/commands/Enable-TssSecretCheckout
[Enable-TssSecretEmail]:/thycotic.secretserver/commands/Enable-TssSecretEmail
[Get-TssSecretHeartbeatStatus]:/thycotic.secretserver/commands/Get-TssSecretHeartbeatStatus
[Get-TssSecretSetting]:/thycotic.secretserver/commands/Get-TssSecretSetting
[Get-TssSecretSummary]:/thycotic.secretserver/commands/Get-TssSecretSummary
[Restore-TssSecret]:/thycotic.secretserver/commands/Restore-TssSecret
[Set-TssSecretField]:/thycotic.secretserver/commands/Set-TssSecretField
[Search-TssSecretTemplate]:/thycotic.secretserver/commands/Search-TssSecretTemplate
[Get-TssUserAudit]:/thycotic.secretserver/commands/Get-TssUserAudit
[Protect-TssSecret]:/thycotic.secretserver/commands/Protect-TssSecret
[Set-TssSecretSecurity]:/thycotic.secretserver/commands/Set-TssSecretSecurity
[Revoke-TssSecret]:/thycotic.secretserver/commands/Revoke-TssSecret
[Set-TssSecretExpiration]:/thycotic.secretserver/commands/Set-TssExpiration
[Set-TssSecretRpcPrivileged]:/thycotic.secretserver/commands/Set-TssSecretRpcPrivileged
[Search-TssDistributedEngineSite]:/thycotic.secretserver/commands/Search-TssDistributedEngineSite
[New-TssUser]:/thycotic.secretserver/commands/New-TssUser
[Get-TssSecretRpcAssociated]:/thycotic.secretserver/commands/Get-TssSecretRpcAssociated

[POST /users]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--users-post
[GET /distributed-engine/sites]:http://argos/SecretServer/documents/restapi/TokenAuth/#operation--distributed-engine-sites-get
[PUT /secrets/{id}/expiration]:http://argos/SecretServer/documents/restapi/TokenAuth/#operation--secrets--id--expiration-put
[POST /secrets/{id}/expire]:http://argos/SecretServer/documents/restapi/TokenAuth/#operation--secrets--id--expire-post
[PATCH /secrets/{id}/security-general]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--security-general-patch
[POST /secrets/{id}/check-in]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--check-in-post
[GET /users/{userId}/audit]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--users--userId--audit-get
[GET /secret-templates]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secret-templates-get
[PUT /secrets/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--put
[POST /secrets/{id}/check-in]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--check-in-post
[PUT /secrets/{id}/undelete]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--undelete-put
[GET /secrets/{id}/summary]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--summary-get
[GET /secrets/stub]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-stub-get
[GET /secrets/{id}/settings]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--settings-get
[POST /secrets/{id}/restricted/fields/{slug}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--restricted-fields--slug--post
[PATCH /secrets/{id}/security-checkout]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--security-checkout-patch
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
[DELETE /folders/{id}/templates/{templateId}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders--id--templates--templateId--delete
[GET /folders/{id}/audit]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders--id--audit-get
[PATCH /folders/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folder--id--patch
[DELETE /folders/{id}]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--folders--id--delete
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
[POST /secrets]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets-post
[POST /secrets/{id}/stop-password-change]:https://updates.thycotic.net/secretserver/restapiguide/10.9.33/TokenAuth/#operation--secrets--id--stop-password-change-post