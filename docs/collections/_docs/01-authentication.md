---
title: "Authentication"
permalink: /docs/authentication/
excerpt: "Thycotic.SecretServer Authentication"
last_modified_at: 2021-02-10T00:00:00-00:00
---

# OAuth2 Authentication

`New-TssSession` is used to request an OAuth token to Secret Server. On successful authentication, the function returns an object with type: `TssSession`. Capturing this object into a variable and providing to functions in the module is required for authenticating.

The mandatory parameters:

- SecretServer - provide the URL used to access your Secret Server web application
- Credential - provide a PSCredential object that contains the Secret Server username and password

## Interactive Login

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

## Automated Login

In automation scenarios, a credential object is created without prompting by utilizing: `[pscredential]::new()`.

```powershell
$username = 'ssadmin'
$password = ConvertTo-SecureString -String 'Y02$r(0m#l3xP@ssw%rd' -AsPlainText -Force
$cred = [pscredential]::new($username,$password)

$session = New-TssSession -SecretServer https://vault.company/SecretServer -Credential $session
```

More: [How to Secure Your Passwords with PowerShell](https://www.sqlshack.com/how-to-secure-your-passwords-with-powershell/).

### SecretManagement Module

Microsoft's PowerShell Team has released a module that offers an efficient, secure, and easily managed option to the other methods commonly used for securely storing your OAuth2 username and password in PowerShell.

More:

- [PowerShell SecretManagement](https://github.com/PowerShell/SecretManagement)
- [PowerShell SecretStore](https://github.com/PowerShell/SecretStore)

## Client SDK (Token)

The Client SDK with Secret Server is a .NET library that allows integration with a custom application. It includes an additional utility that is accessible from the command line (`tss.exe`). The authentication is done via the SDK Client Management configuration. Access can be restricted by IP Address, and user assignment controls what operations with secrets are allowed. The primary use of this is to quickly get a token and prevent the need for using a username and password combo, as is required with OAuth2 authentication.

When using the Client SDK against Secret Server Cloud subscription, the IP filtering is based on your machine's public IP at this time.
{: .notice--info}

### Client SDK Setup

1. Download the Client SDK and extract it to your device
2. Open a PowerShell session to that directory (`Set-Location c:\tools\SecretServerClientSdk`)
3. Connect the SDK installation to your Secret Server

    ```powershell
    Set-Location 'c:\tools\SecretServerClientSdk'
    .\tss.exe init -u https://vault.company/SecretServer -r demo_rule
    ```

    Sample output:

    ```console
    ----------
    Your SDK client account registration is complete.
    ```

    Once this is completed, a group of configuration files is created within the local directory. You must always call this utility from the tool's location; reference it from another directory can cause issues with the initialization being deleted.
    {: .notice--warning}

4. If you need to reset the configuration, you can do that using `.\tss.exe remove.`
5. You can verify what Secret Server endpoint `tss` is connected to using `.\tss.exe status`

    ```powershell
    .\tss.exe status
    ```

    Sample output:

    ```console
    Connected to endpoint https://vault.company/SecretServer
    ```

6. The following can be used to create a `TssSession` object to use with the module's functions:

    ```powershell
    $token = .\tss.exe token
    $session = New-TssSession -SecretServer https://vault.company/SecretServer -AccessToken $token
    $session
    ```

    Sample output:

    ```console

    SecretServer : https://vault.company/SecretServer/
    ApiVersion   : api/v1
    ApiUrl       :
    AccessToken  : AgK3w9pUTsXdsAZYH846FZBxC6bvWQJdoX8ENekIwMBytx_H_lWJ...
    RefreshToken :
    TokenType    :
    ExpiresIn    : 0
    Take         : 2147483647
    ```

## Alias

A 3-character alias, `nts`, exists in the module for use in an interactive session to help save typing.

```powershell
$cred = Get-Credential
$session = nts 'https://tenant.secretservercloud.com' $cred
```

## Methods

Methods are available on the `New-TssSession` object to help with session management in your automation process. You can find these by piping to `Get-Member`.

```powershell
$session | Get-Member
```

Sample output:

```console
   TypeName: TssSession

Name           MemberType Definition
----           ---------- ----------
Equals         Method     bool Equals(System.Object obj)
GetHashCode    Method     int GetHashCode()
GetType        Method     type GetType()
IsValidSession Method     bool IsValidSession()
IsValidToken   Method     bool IsValidToken()
SessionExpire  Method     bool SessionExpire()
SessionRefresh Method     bool SessionRefresh()
ToString       Method     string ToString()
AccessToken    Property   string AccessToken {get;set;}
ApiUrl         Property   string ApiUrl {get;set;}
ApiVersion     Property   string ApiVersion {get;set;}
ExpiresIn      Property   int ExpiresIn {get;set;}
RefreshToken   Property   string RefreshToken {get;set;}
SecretServer   Property   string SecretServer {get;set;}
Take           Property   int Take {get;set;}
TokenType      Property   string TokenType {get;set;}
```

Note that these methods are defined as `boolean`, so they will only return true or false; the intent is to utilize them in workflow validation (e.g., `if/else`).
{: .notice--info}

### IsValidToken

This method utilizes a hidden properties on the `TssObject` called `TimeOfDeath` (`datetime` type). The value of this property is calculated based on the `expires_in` value returned by the OAuth2 endpoint and based on the local time of the machine calling the function.

More details: [TssSession source code](https://github.com/thycotic-ps/thycotic.secretserver/blob/master/src/classes/TssSession.class.ps1)

### IsValidSession

This method does a basic check to validate the following:

- `TssSession` property `AccessToken` has a value
- A hidden property on `TssSession` called `StartTime` is set to a current time.

### SessionExpire

Disposing of connections to systems is good practice in your scripts. Secret Server REST API offers the ability to expire the token issued for an authenticated session. The endpoint used is /oauth-expiration. A method is added to the TssSession object where you can call this method, and your token for that session will be expired.

```powershell
$cred = Get-Credential
$session = New-TssSession -SecretServer https://vault.company/SecretServer -Credential $cred

<# Do processing #>
$session.SessionExpire()
```

After calling the method, any further use of that $session object will result in an error referencing an expired token.

### SessionRefresh

This method is utilizing the refresh token according to the Secret Server Webservices configuration. It will call the endpoint and provide the required details to request a new token to allow your session to continue authenticating. The number of times you can use this method is directly related to the Maximum Token Refreshes Allowed configuration of your Secret Server configuration.

Secret Server's default for Webservices:

**Setting** | **Value** |
---------------- | -------- |
Enable Webservices | Yes
Session Timeout for Webservices | 20 minutes
Enable Refresh Tokens for Web Services | Yes
Maximum Token Refreshes Allowed | 3

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
