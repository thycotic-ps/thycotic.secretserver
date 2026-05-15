---
title: Secret
parent: Secrets
grand_parent: Types
---

# Secret

**Kind:** class  
**Full name:** `Thycotic.PowerShell.Secrets.Secret`  
**Namespace:** `Thycotic.PowerShell.Secrets`  

## Constructors

- `new()` _(default)_

## Properties

| Name | Type | Access | Default |
|---|---|---|---|
| `AccessRequestWorkflowMapId` | `int` | read/write | — |
| `Active` | `bool` | read/write | — |
| `AllowOwnersUnrestrictedSshCommands` | `bool` | read/write | — |
| `AutoChangeEnabled` | `bool` | read/write | — |
| `AutoChangeNextPassword` | `string` | read/write | — |
| `CheckedOut` | `bool` | read/write | — |
| `CheckOutChangePasswordEnabled` | `bool` | read/write | — |
| `CheckOutEnabled` | `bool` | read/write | — |
| `CheckOutIntervalMinutes` | `int` | read/write | — |
| `CheckOutMinutesRemaining` | `int` | read/write | — |
| `CheckOutUserDisplayName` | `string` | read/write | — |
| `CheckOutUserId` | `int` | read/write | — |
| `DoubleLockId` | `int` | read/write | — |
| `EnableInheritPermissions` | `bool` | read/write | — |
| `EnableInheritSecretPolicy` | `bool` | read/write | — |
| `FailedPasswordChangeAttempts` | `int` | read/write | — |
| `Filename` | `string` | read/write | — |
| `FolderId` | `int` | read/write | — |
| `hsmKeyIdentifier` | `string` | read/write | — |
| `Id` | `int` | read/write | — |
| `IsDoubleLock` | `bool` | read/write | — |
| `IsOutOfSync` | `bool` | read/write | — |
| `IsRestricted` | `bool` | read/write | — |
| `Items` | `Items[]` | read/write | — |
| `JumpboxRouteId` | `int?` | read/write | — |
| `LastHeartBeatCheck` | `DateTime?` | read/write | — |
| `LastHeartBeatStatus` | `SecretHeartbeatStatus` | read/write | — |
| `LastPasswordChangeAttempt` | `DateTime?` | read/write | — |
| `LauncherConnectAsSecretId` | `int` | read/write | — |
| `Name` | `string` | read/write | — |
| `OutOfSyncReason` | `string` | read/write | — |
| `PasswordTypeWebScriptId` | `int` | read/write | — |
| `ProxyEnabled` | `bool` | read/write | — |
| `RequiresApprovalForAccess` | `bool` | read/write | — |
| `RequiresComment` | `bool` | read/write | — |
| `ResponseCodes` | `string[]` | read/write | — |
| `RestrictSshCommands` | `bool` | read/write | — |
| `SecretPolicyId` | `int` | read/write | — |
| `SecretTemplateId` | `int` | read/write | — |
| `SecretTemplateName` | `string` | read/write | — |
| `SessionRecordingEnabled` | `bool` | read/write | — |
| `SiteId` | `int` | read/write | — |
| `SlugName` | `string` | read/write | — |
| `WebLauncherRequiresIncognitoMode` | `bool` | read/write | — |

## Methods

- `[PSCredential] GetCredential(string DomainField, string UserField, string PasswordField)`
- `[string] GetFieldValue(string SlugName)`
- `[List<FileField>] GetFileFields()`
- `[void] SetFieldValue(string SlugName, string NewValue)`
- `[void] UpdateFieldId(string SlugName, int OrginalId, int NewId)`


