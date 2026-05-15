---
title: DetailState
parent: Secrets
grand_parent: Types
---

# DetailState

**Kind:** class  
**Full name:** `Thycotic.PowerShell.Secrets.DetailState`  
**Namespace:** `Thycotic.PowerShell.Secrets`  

## Constructors

- `new()` _(default)_

## Properties

| Name | Type | Access | Default |
|---|---|---|---|
| `Actions` | `string[]` | read/write | — |
| `CheckedOutUserDisplayname` | `string` | read/write | — |
| `CheckedOutUserId` | `int` | read/write | — |
| `CheckOutIntervalMinutes` | `int` | read/write | — |
| `CheckOutMinutesRemaining` | `int` | read/write | — |
| `FolderId` | `int` | read/write | — |
| `FolderName` | `string` | read/write | — |
| `Id` | `int` | read/write | — |
| `IsActive` | `bool` | read/write | — |
| `IsCheckedOut` | `bool` | read/write | — |
| `IsCheckedOutByCurrentUser` | `bool` | read/write | — |
| `PasswordChangePending` | `bool` | read/write | — |
| `Role` | `string` | read/write | — |
| `SecretName` | `string` | read/write | — |
| `SecretState` | `SecretStates` | read/write | — |

## Methods

- `[bool] TestAction(string ActionName)`
- `[bool] TestState(string State)`


