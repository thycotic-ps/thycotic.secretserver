function New-TssPasswordTypeAuth {
    <#
    .SYNOPSIS
    Add a command credential to a password type

    .DESCRIPTION
    Add a command credential (password type auth record) to a password type for one command slot.
    CommandTypeCode picks the slot: 1 reset password, 2 verify password, 3 reset password by other credentials, 4 post-success commands, 5 post-failure commands.
    A password type holds at most one record per slot; the server rejects a duplicate. Change an existing record with Set-TssPasswordTypeAuth.
    There is no REST route to delete a record.
    The output is every command credential of that password type, stored secrets included in clear text: handle it as secret material.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password type ID

    .PARAMETER CommandTypeCode
    Command slot, 1 to 5: 1 reset password, 2 verify password, 3 reset password by other credentials, 4 post-success commands, 5 post-failure commands

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
    $slotPassword = Read-Host -AsSecureString
    New-TssPasswordTypeAuth -TssSession $session -Id 9 -CommandTypeCode 3 -Username 'svc-rpc' -Password $slotPassword

    Add a reset-by-other-credentials slot (code 3) to password type 9 that runs as svc-rpc

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/New-TssPasswordTypeAuth

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/New-TssPasswordTypeAuth.ps1

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
        [Alias('PasswordTypeId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [ValidateRange(1, 5)]
        [int]
        $CommandTypeCode,

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
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ commandTypeCode = $CommandTypeCode } }
            switch ($tssParams.Keys) {
                'Username' {
                    $body.data.Add('username', $Username)
                }
                'Password' {
                    $body.data.Add('password', [System.Net.NetworkCredential]::new('', $Password).Password)
                }
                'Key' {
                    $body.data.Add('key', $Key)
                }
                'Passphrase' {
                    $body.data.Add('passphrase', [System.Net.NetworkCredential]::new('', $Passphrase).Password)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Password type: $Id, command type code: $CommandTypeCode", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssPasswordTypeAuth request'
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
