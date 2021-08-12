---
sort: 4
---

# Invoke-TssRestApi

This is a public function that offers an option to simplify making raw REST API calls with Secret Server.

## What PowerShell's Command(s)

In PowerShell, you can utilize `Invoke-RestMethod` or `Invoke-WebRequest` for making any web request or API call. The `Invoke-TssRestApi` is a wrapper script around `Invoke-RestMethod` and helps take out some required pre-coding. An authentication header for example has to be provided to Secret Server when you make any API call, with the public function `Invoke-TssRestApi` you can provide the token via `-PersonalAccessToken` parameter and it handles building the header object required.

Below are a few coded examples for how it can be used if needed.

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

### Example Output

```console
itemId           : 113
fileAttachmentId :
filename         :
itemValue        : 10.10.10.2
fieldId          : 276
fieldName        : Server
slug             : server
fieldDescription : The Server or Location of the SQL Server.
isFile           : False
isNotes          : False
isPassword       : False

itemId           : 119
fileAttachmentId :
filename         :
itemValue        : 9042
fieldId          : 282
fieldName        : Port
slug             : port
fieldDescription : Port used for server connection
isFile           : False
isNotes          : False
isPassword       : False
...
itemId           : 116
fileAttachmentId :
filename         :
itemValue        :
fieldId          : 279
fieldName        : Notes
slug             : notes
fieldDescription : Any additional notes.
isFile           : False
isNotes          : True
isPassword       : False
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

### Example Output

```console
itemId           : 113
fileAttachmentId :
filename         :
itemValue        : 10.10.10.2
fieldId          : 276
fieldName        : Server
slug             : server
fieldDescription : The Server or Location of the SQL Server.
isFile           : False
isNotes          : False
isPassword       : False
CurrentDateTime  : 8/11/2021 11:04:49 PM

itemId           : 119
fileAttachmentId :
filename         :
itemValue        : 9042
fieldId          : 282
fieldName        : Port
slug             : port
fieldDescription : Port used for server connection
isFile           : False
isNotes          : False
isPassword       : False
CurrentDateTime  : 8/11/2021 11:04:49 PM
...
itemId           : 116
fileAttachmentId :
filename         :
itemValue        :
fieldId          : 279
fieldName        : Notes
slug             : notes
fieldDescription : Any additional notes.
isFile           : False
isNotes          : True
isPassword       : False
CurrentDateTime  : 8/11/2021 11:04:49 PM
```

## Remove a Property from Output

The `-RemoveProperty` parameter is used to remove any properties from the output object.

```powershell
$session = New-TssSession -SecretServer 'https://tenant.secretservercloud.com' -Credential $secretCloudCred
$invokeParams = @{
  Uri = "$($session.SecretServer)/api/v1/users/2"
  Method = 'Get'
  PersonalAccessToken = $session.AccessToken
}
Invoke-TssRestApi @invokeParams | Format-Table
```

### Example Output

```console
id userName            displayName           lastLogin           created             enabled loginFailures emailAddress
-- --------            -----------           ---------           -------             ------- ------------- ------------
 2 John.Doe@domain.com John.Doe@domain.com   2020-07-27T21:17:22 2020-07-22T14:20:14 False   0             John.Doe@domain.c...
```