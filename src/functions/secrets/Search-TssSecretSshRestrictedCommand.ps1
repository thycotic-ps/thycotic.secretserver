function Search-TssSecretSshRestrictedCommand {
    <#
    .SYNOPSIS
    Get the SSH command restrictions of a secret

    .DESCRIPTION
    Returns the restriction type and the SSH command menus and blocklists that apply to the secret, per group or role.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER AutoCheckIn
    Check the secret back in after the request completes

    .PARAMETER AutoCheckout
    Check out the secret automatically when it requires checkout

    .PARAMETER AutoComment
    Comment to record with the automatic checkout, for secrets that require a comment

    .PARAMETER ForceCheckIn
    Force check in the secret if another user has it checked out

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecretSshRestrictedCommand -TssSession $session -Id 42

    Returns the SSH command restrictions of secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Search-TssSecretSshRestrictedCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Search-TssSecretSshRestrictedCommand.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires a Secret Server license that includes SSH command restrictions.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Secrets.SshRestrictedCommand')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        [switch]
        $AutoCheckIn,

        [switch]
        $AutoCheckout,

        [string]
        $AutoComment,

        [switch]
        $ForceCheckIn
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
                $uri = $TssSession.ApiUrl, 'secrets', $currentId, 'ssh-restricted-commands' -join '/'
                $queryParams = @()
                switch ($tssParams.Keys) {
                    'AutoCheckIn' {
                        $queryParams += "autoCheckIn=$([boolean]$AutoCheckIn)"
                    }
                    'AutoCheckout' {
                        $queryParams += "autoCheckout=$([boolean]$AutoCheckout)"
                    }
                    'AutoComment' {
                        $queryParams += "autoComment=$([uri]::EscapeDataString($AutoComment))"
                    }
                    'ForceCheckIn' {
                        $queryParams += "forceCheckIn=$([boolean]$ForceCheckIn)"
                    }
                }
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Search-TssSecretSshRestrictedCommand request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.SshRestrictedCommand](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.SshRestrictedCommand]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
