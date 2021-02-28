---
title: "Invoke-TssRestApi"
permalink: /docs/invoketssrestapi/
excerpt: "Thycotic.SecretServer raw API calls"
last_modified_at: 2021-02-10T00:00:00-00:00
---

The module functions utilize this command for calling endpoints. The functions are meant to handle formatting the output where it can be more easily read and utilzied for processing in PowerShell scripts. If you want to see the raw endpoint's output you can utilize `Invoke-TssRestApi` for that purpose.

## What about Invoke-RestMethod

In PowerShell, the cmdlet used for REST API calls is `Invoke-RestMethod`, and Thycotic.SecretServer uses this same command. The `Invoke-TssRestApi` acts as a wrapper to `Invoke-RestMethod` with a few additions:

- Deals with creating the required header object for Secret Server using `-PersonalAccessToken`
- Unwrap objects returned by an endpoint easily using `-ExpandProperty`

## Basic Use

```powershell
$session = New-TssSession -SecretServer 'https://vault.local/SecretServer' -Credential $secretCloudCred
$invokeParams = @{
  Uri = "$($session.SecretServer)/api/v1/secrets/27"
  Method = 'Get'
  PersonalAccessToken = $session.AccessToken
  ExpandProperty = 'items'
}
Invoke-TssRestApi @invokeParams
```

## Add Property in Output

The `-Property` parameter can be used to add additional properties to a given output object (i.e., logging purposes ):

```powershell
$session = New-TssSession -SecretServer 'https://tenant.secretservercloud.com' -Credential $secretCloudCred
$invokeParams = @{
  Uri = "$($session.SecretServer)/api/v1/secrets/27"
  Method = 'Get'
  PersonalAccessToken = $session.AccessToken
  ExpandProperty = 'items'
  Property = @{CurrentDateTime = Get-Date}
}
Invoke-TssRestApi @invokeParams
```

## Remove a Property from Output

The `-RemoveProperty` parameter is used to remove any properties from the output object.

```powershell
$session = New-TssSession -SecretServer 'https://tenant.secretservercloud.com' -Credential $secretCloudCred
$invokeParams = @{
  Uri = "$($session.SecretServer)/api/v1/secrets/27"
  Method = 'Get'
  PersonalAccessToken = $session.AccessToken
  ExpandProperty = 'items'
  RemoveProperty = 'itemid'
}
Invoke-TssRestApi @invokeParams
```
