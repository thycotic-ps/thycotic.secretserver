function Set-TssDatabaseConfiguration {
    <#
    .SYNOPSIS
    Set the database configuration

    .DESCRIPTION
    Updates the SQL Server connection settings Secret Server uses and returns the updated configuration. Secret Server validates the new connection before it saves it.
    With SQL Server authentication, send the Password parameter even when the password is not changing.
    A wrong value can take Secret Server offline. Only the parameters you pass are sent; switch parameters send their value, so -Name:$false turns a setting off.
    The database configuration is set per web node: the change applies only to the node that receives the request, so the session must point directly at that node, not at a load-balanced address.
    The command writes that warning and asks OK to proceed? before it sends the request. -Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER AuthenticationType
    How Secret Server authenticates to SQL Server

    .PARAMETER ConnectionTimeout
    Connection timeout in seconds

    .PARAMETER DatabaseName
    Database name

    .PARAMETER EnableMultiSubnetFailover
    Use multi-subnet failover (availability groups)

    .PARAMETER EnableSslEncryption
    Encrypt the connection to SQL Server

    .PARAMETER FailoverPartner
    Failover partner server

    .PARAMETER FileOverridePassword
    Password of the -FileOverrideUserName account

    .PARAMETER FileOverrideUserName
    Windows account used to write the database configuration file on the web server

    .PARAMETER Password
    SQL Server login password, used with SQL Server authentication

    .PARAMETER ServerName
    SQL Server name, or server\instance

    .PARAMETER TrustServerCertificate
    Trust the SQL Server certificate without validating its chain

    .PARAMETER UserName
    SQL Server login name, used with SQL Server authentication

    .PARAMETER Force
    Skip the OK to proceed? question, and the confirmation prompt unless -Confirm is passed. The warning is still written.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssDatabaseConfiguration -TssSession $session -EnableSslEncryption -TrustServerCertificate:$false

    Encrypt the database connection and validate the SQL Server certificate

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssDatabaseConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssDatabaseConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server on-premises only (the endpoint is blocked in Secret Server Cloud).
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Configuration.DatabaseConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [ValidateSet('WindowsAuth', 'SqlAuth', 'AADIntegrated', 'AADSqlAuth', 'ManagedIdentity')]
        [string]
        $AuthenticationType,

        [int]
        $ConnectionTimeout,

        [string]
        $DatabaseName,

        [switch]
        $EnableMultiSubnetFailover,

        [switch]
        $EnableSslEncryption,

        [string]
        $FailoverPartner,

        [securestring]
        $FileOverridePassword,

        [string]
        $FileOverrideUserName,

        [securestring]
        $Password,

        [string]
        $ServerName,

        [switch]
        $TrustServerCertificate,

        [string]
        $UserName,

        [switch]
        $Force
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'database' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'AuthenticationType' {
                    $body.data.Add('authenticationType', @{ dirty = $true; value = $AuthenticationType })
                }
                'ConnectionTimeout' {
                    $body.data.Add('connectionTimeout', @{ dirty = $true; value = $ConnectionTimeout })
                }
                'DatabaseName' {
                    $body.data.Add('databaseName', @{ dirty = $true; value = $DatabaseName })
                }
                'EnableMultiSubnetFailover' {
                    $body.data.Add('enableMultiSubnetFailover', @{ dirty = $true; value = [boolean]$EnableMultiSubnetFailover })
                }
                'EnableSslEncryption' {
                    $body.data.Add('enableSslEncryption', @{ dirty = $true; value = [boolean]$EnableSslEncryption })
                }
                'FailoverPartner' {
                    $body.data.Add('failoverPartner', @{ dirty = $true; value = $FailoverPartner })
                }
                'FileOverridePassword' {
                    $body.data.Add('fileOverridePassword', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $FileOverridePassword).Password })
                }
                'FileOverrideUserName' {
                    $body.data.Add('fileOverrideUserName', @{ dirty = $true; value = $FileOverrideUserName })
                }
                'Password' {
                    $body.data.Add('password', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $Password).Password })
                }
                'ServerName' {
                    $body.data.Add('serverName', @{ dirty = $true; value = $ServerName })
                }
                'TrustServerCertificate' {
                    $body.data.Add('trustServerCertificate', @{ dirty = $true; value = [boolean]$TrustServerCertificate })
                }
                'UserName' {
                    $body.data.Add('userName', @{ dirty = $true; value = $UserName })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if (Confirm-TssDangerousOperation $PSCmdlet NodeDatabaseConfiguration "Database configuration" "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)" -Force:$Force) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssDatabaseConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.DatabaseConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.DatabaseConfiguration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
