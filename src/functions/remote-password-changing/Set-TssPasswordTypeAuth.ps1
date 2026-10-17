function Set-TssPasswordTypeAuth {
    <#
    .SYNOPSIS
    Update a command credential of a password type

    .DESCRIPTION
    Update one existing command credential (password type auth record) of a password type.
    Only the values you pass are changed; the others keep their stored value.
    The output is every command credential of that password type, stored secrets included in clear text: handle it as secret material.
    Use New-TssPasswordTypeAuth to add a record for a command slot that has none.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password type auth ID (the Id property of Get-TssPasswordTypeAuth output), not the password type ID

    .PARAMETER Username
    Username the command slot runs as

    .PARAMETER Password
    Password the command slot uses

    .PARAMETER Key
    Private key text the command slot uses

    .PARAMETER Passphrase
    Passphrase of the private key

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $newPassword = Read-Host -AsSecureString
    Set-TssPasswordTypeAuth -TssSession $session -Id 3 -Username 'svc-rpc' -Password $newPassword

    Set the username and password of password type auth record 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPasswordTypeAuth -TssSession $session -Id 9 | Where-Object CommandTypeCode -eq 2 | Set-TssPasswordTypeAuth -TssSession $session -Username 'verify-user'

    Change the username of the verify-password command slot (code 2) of password type 9

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Set-TssPasswordTypeAuth

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Set-TssPasswordTypeAuth.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Rpc.PasswordTypeAuth[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('PasswordTypeAuthId')]
        [int]
        $Id,

        [string]
        $Username,

        [securestring]
        $Password,

        [string]
        $Key,

        [securestring]
        $Passphrase
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'password-type-auth', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Username' {
                    $body.data.Add('username', @{ dirty = $true; value = $Username })
                }
                'Password' {
                    $body.data.Add('password', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $Password).Password })
                }
                'Key' {
                    $body.data.Add('key', @{ dirty = $true; value = $Key })
                }
                'Passphrase' {
                    $body.data.Add('passphrase', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $Passphrase).Password })
                }
            }
            if ($body.data.Count -eq 0) {
                Write-Error 'Provide at least one of -Username, -Password, -Key or -Passphrase'
                return
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Password type auth: $Id", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssPasswordTypeAuth request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.commands) {
                    [Thycotic.PowerShell.Rpc.PasswordTypeAuth[]](. $FilterTssResponse $restResponse.commands ([Thycotic.PowerShell.Rpc.PasswordTypeAuth]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
