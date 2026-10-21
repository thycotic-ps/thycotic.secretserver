---
title: Session
parent: Authentication
grand_parent: Types
---

# Session

**Kind:** class  
**Full name:** `Thycotic.PowerShell.Authentication.Session`  
**Namespace:** `Thycotic.PowerShell.Authentication`  

## Constructors

- `new()` _(default)_

## Properties

| Name | Type | Access | Default |
|---|---|---|---|
| `access_token` | `string` | read/write | — |
| `AccessToken` | `string` | read/write | — |
| `ApiUrl` | `string` | read/write | — |
| `ApiVersion` | `string` | read/write | `"api/v1"` |
| `expires_in` | `int` | read/write | — |
| `ExpiresIn` | `int` | read/write | — |
| `refresh_token` | `string` | read/write | — |
| `RefreshToken` | `string` | read/write | — |
| `SecretServer` | `string` | read/write | — |
| `SecretServerVersion` | `string` | read/write | — |
| `SkipCertificateCheck` | `bool` | read/write | `false` |
| `StartTime` | `DateTime` | read/write | — |
| `Take` | `int` | read/write | `int.MaxValue` |
| `TimeOfDeath` | `DateTime` | read/write | — |
| `token_type` | `string` | read/write | — |
| `TokenType` | `string` | read/write | — |
| `WindowsAuth` | `string` | readonly | `"winauthwebservices"` |

## Methods

- `[static RestResponse] AccessToken(string SecretServerHost, string Username, string Password, string ProxyServer, int Timeout = 0)`
- `[bool] CheckTokenTtl(int Value)`
- `[bool] IsValidSession()`
- `[bool] IsValidToken()`
- `[static RestResponse] RefreshToken(string SecretServerHost, string TokenValue, string ProxyServer, int Timeout = 0)`
- `[bool] SessionExpire()`
- `[bool] SessionRefresh()`


