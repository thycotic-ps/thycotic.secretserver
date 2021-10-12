---
sort: 2
---

# Authentication

## TssSession Object

The `TssSession` is the output from calling [New-TssSession](/thycotic.secretserver/commands/authentication/New-TssSession). All functions in the module depend on that object being provided and have a matching `-TssSession` parameter.

## Windows Integrated Authentication (IWA)

To utilize Windows Authentication with Secret Server, your administrator will need to go through [configuring Webservers to support IWA](https://docs.thycotic.com/ss/10.9.0/api-scripting/webservice-iwa-powershell/index.md).

As of **version `0.30.0`**, Windows Authentication is supported with the module. `New-TssSession` now has the parameter `-UseWindowsAuth` for this purpose. See examples of this use via the command help

## OAuth2 Authentication

Authenticating with a username and password creates creating that as a `PSCredential` object and then providing that to the `-Credential` parameter of `New-TssSession`.

### Interactive Login

Use of `Get-Credential` will provide a prompt to enter the username and password for interactive login:

```powershell
$cred = Get-Credential
$session = New-TssSession -SecretServer https://vault.company.com -Credential $cred
$session
```

Sample output:

```console
PowerShell credential request
Enter your credentials.
User: ssadmin
Password for user ssadmin: **********

Username                     Password
--------                     --------
ssadmin  System.Security.SecureString

ApiVersion   : api/v1
Take         : 2147483647
SecretServer : https://vault.company.com
ApiUrl       : https://vault.company.com/api/v1
AccessToken  : AgLNqrQSDBTFqX7WMq-UPJB98jLiuu3wS7LDPuSJhV_ToE3l...
RefreshToken : W4mBfzU4q5nXuMIZzG2OLx4J1Mvgle-5IpbephF5yrOpIsvk...
TokenType    : bearer
ExpiresIn    : 1199
```

### Automated Login

In automation scenarios, a credential object is created without prompting by utilizing: `[pscredential]::new()`.

```powershell
$username = 'ssadmin'
$password = ConvertTo-SecureString -String 'Y02$r(0m#l3xP@ssw%rd' -AsPlainText -Force
$cred = [pscredential]::new($username,$password)

$session = New-TssSession -SecretServer https://vault.company/SecretServer -Credential $session
```

## SecretManagement Module

Microsoft's PowerShell Team's [SecretManagement](https://devblogs.microsoft.com/powershell/secretmanagement-and-secretstore-are-generally-available/) modules give you a universal abstraction layer for management of credentials that you need to use in your scripts on a given machine. These modules are cross-platform and can be used on **any** operating system that Windows PowerShell or Powershell 7+ are supported. Your admins can leverage these two modules to more secure store the credential needed for authenticating to Secret Server.

### Create the local Secret Store

```powershell
# Install-Module Microsoft.PowerShell.SecretManagement -Scope AllUsers -Force
Import-Module Microsoft.PowerShell.SecretStore, Microsoft.PowerShell.SecretManagement

<# First time register the SecretStore vault as the default #>
Register-SecretVault -Name SecretStore -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault
Register-SecretVault -Name scripts -ModuleName Microsoft.PowerShell.SecretStore -DefaultVault

<# See two vaults are created #>
Get-SecretVault

Set-SecretVaultDefault -Name scripts

<# Unregistered/remove a vault #>
UnRegister-SecretVault SecretStore
```

### Create a Secret

```powershell

# Store a password
Set-Secret -Name apidemoPwd -SecureStringSecret (ConvertTo-SecureString 'P@ssword$01' -AsPlainText -Force)

# Store a full Credential object
$cred = [pscredential]::new('apidemo',(ConvertTo-SecureString 'P@ssword$01' -AsPlainText -Force))
Set-Secret -Name apidemoCred -Secret $cred

# use stored password for authentication

# Get the SecureString created for apidemo account
$apiCred = [pscredential]::new('apidemo',(Get-Secret apidemoPwd))
# Use in API call
$SecretServerHost = 'http://argos/secretserver'
$session = New-TssSession -SecretServer $SecretServerHost -Credential $apiCred

# vs full credential being stored
$SecretServerHost = 'http://argos/secretserver'
$session = New-TssSession -SecretServer $SecretServerHost -Credential (Get-Secret apidemo)
```

More:

- [PowerShell SecretManagement](https://github.com/PowerShell/SecretManagement)
- [PowerShell SecretStore](https://github.com/PowerShell/SecretStore)


## PowerShell Profile

Using the details in this article to this point we can build a shortcut in our PowerShell profile. Your profile in PowerShell allows you to add repeatable code or functions that can make your life much easier. A common practice with system management is adding a quick function in your profile to login you into your applications that you use day-to-day. One of these can be Secret Server, and the below is a snippet the maintainers of the module utilize.

### Creating the Profile script

If you have never used your profile in PowerShell before you may need to create the file, this can be done with the following command:

```powershell
New-Item $PROFILE -ItemType File -Force
```

After the above you can then open the file up in your favorite code editor:

```powershell
code-insiders $PROFILE
```

### Login Snippet for Secret Server

Below script can be added to your profile script, adjust as you need for your environment:

```powershell
function Login-SS {
   $ssUrl = 'https://vault.company.com/SecretServer'
   Import-Module Thycotic.SecretServer -Force
   $cred = Get-Secret secretserverCred
   $s = New-TssSession -SecretServer $ssUrl -Credential $cred
   New-Variable -Name session -Value $s -Scope Global -Force
   if (-not $ignoreDefault) {
      $PSDefaultParameterValues.Remove("*:TssSession")
      $PSDefaultParameterValues.Remove("*:PersonalAccessToken")
      $PSDefaultParameterValues.Add("*:TssSession",$session)
      $PSDefaultParameterValues.Add("*:PersonalAccessToken",$session.AccessToken)
   }
}
```

The use of `$PSDefaultParameterValues` allows you to set the default values for those parameters and applies to all commands in the module. You can see in the below example that `-TssSession` is not directly provided.

```powershell
Login-SS
$ad = Get-TssSecretStub -SecretTemplateId 6001 -FolderId 37
$ad.Name = 'Test Secret with Incognito Policy 1'
$ad.SetFieldValue('Domain','somedomain');$ad.SetFieldValue('Username','someuser');$ad.SetFieldValue('Password','somepassword');
$ad.WebLauncherRequiresIncognitoMode
New-TssSecret -SecretStub $ad
```

# Methods

The `TssSession` object contains custom methods that allow you to easily perform certain actions with the object. You can find these by piping to `Get-Member`.

```powershell
$session | Get-Member
```

## IsValidToken

This method utilizes a hidden properties on the `TssObject` called `TimeOfDeath` (`datetime` type). This property's value is calculated based on the `expires_in` value returned by the OAuth2 endpoint and based on the machine's local time calling the function.

More details: [TssSession source code](https://github.com/thycotic-ps/thycotic.secretserver/blob/master/src/classes/TssSession.class.ps1)

## IsValidSession

This method does a basic check to validate the following:

- `TssSession` property `AccessToken` has a value
- A hidden property on `TssSession` called `StartTime` is set to a current time.

## SessionExpire

Disposing of connections to systems is good practice in your scripts. Secret Server REST API offers the ability to expire the token issued for an authenticated session. The endpoint used is /oauth-expiration. A method is added to the TssSession object where you can call this method, and your token for that session will be expired.

```powershell
$cred = Get-Credential
$session = New-TssSession -SecretServer https://vault.company/SecretServer -Credential $cred

<# Do processing #>
$session.SessionExpire()
```

After calling the method, any further use of that $session object will result in an error referencing an expired token.

## SessionRefresh

This method is utilizing the refresh token according to the Secret Server Webservices configuration. It will call the endpoint and provide the required details to request a new token to allow your session to continue authenticating. The number of times you can use this method is directly related to the Maximum Token Refreshes Allowed configuration of your Secret Server configuration.

Secret Server's default for Webservices:

| **Setting**                            | **Value**  |
| -------------------------------------- | ---------- |
| Enable Webservices                     | Yes        |
| Session Timeout for Webservices        | 20 minutes |
| Enable Refresh Tokens for Web Services | Yes        |
| Maximum Token Refreshes Allowed        | 3          |

The default configuration translates to having the ability to request a session token four times in total (initial auth, then three refreshes). After you reach the refresh limit, you will begin receiving errors from the endpoint on an invalid request.

```powershell
$session = New-TssSession -SecretServer https://vault.company/SecretServer -Credential $cred
$session
$session.SessionRefresh()
$session
```

Sample output:

```console

ApiVersion   : api/v1
Take         : 2147483647
SecretServer : http://vault3/
ApiUrl       : http://vault3/api/v1
AccessToken  : AgKZPsE1OFcSDO9v1kHLi7eS3LbTDY9jUxvDLSUNoY-X3yGw5yi2fAW8...
RefreshToken : R7PFSfZtA4xRV8_dEPtFKuA7S18wrWjUAfKkkYN6n-MSe1LY0t5nz4Nc...
TokenType    : bearer
ExpiresIn    : 1200

True

ApiVersion   : api/v1
Take         : 2147483647
SecretServer : http://vault3/
ApiUrl       : http://vault3/api/v1
AccessToken  : AgL7iBqqiBfXo7CLjvUFdik3B2Eu0GJB2N_nnm2OaLZrGnrpFnad5APi...
RefreshToken : XbAhOylNtMnzOTcrIIdCDZdIFHn_gC7VkdgS-BhTEtSK2Iwt0IAWf13s...
TokenType    : bearer
ExpiresIn    : 1199
```
