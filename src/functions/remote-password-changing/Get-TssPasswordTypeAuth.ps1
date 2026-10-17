function Get-TssPasswordTypeAuth {
    <#
    .SYNOPSIS
    Get the command credentials of a password type

    .DESCRIPTION
    Get the command credentials (password type auth records) stored on a password type.
    Each record is one command slot (CommandTypeCode 1 to 5) with the username, password, key and passphrase the password changer uses for that slot.
    The output carries those stored credentials in clear text: handle it as secret material.
    Only SSH password types with custom commands hold command credentials; other password types return Access Denied.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Password type ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPasswordTypeAuth -TssSession $session -Id 9

    Get the command credential records of password type 9

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssRpcPasswordType -TssSession $session -SearchText 'SSH' | Where-Object HasCommands | Get-TssPasswordTypeAuth -TssSession $session | Select-Object Id, PasswordTypeId, CommandTypeCode, Username

    List the command slots of the SSH password types that have custom commands, without showing the stored secrets

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Get-TssPasswordTypeAuth

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Get-TssPasswordTypeAuth.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Rpc.PasswordTypeAuth[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('PasswordTypeId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'remote-password-changing', 'password-type-auth', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssPasswordTypeAuth request'
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
