function Enable-TssSecret {
    <#
    .SYNOPSIS
    Activate a deleted secret

    .DESCRIPTION
    Activates (undeletes) a deleted secret through the v3 activate endpoint and returns Success.
    Success is True when the secret is already active.
    Restore-TssSecret does the same through the older undelete endpoint.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Enable-TssSecret -TssSession $session -Id 42

    Activates secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSecret -TssSession $session -IncludeInactive -ExcludeActive | Enable-TssSecret -TssSession $session -WhatIf

    Shows which deleted secrets would be activated

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Enable-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Enable-TssSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.ActivateResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
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
                $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v3'), 'secrets', $currentId, 'activate' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'
                if ($PSCmdlet.ShouldProcess("Secret: $currentId", "$($invokeParams.Method) $uri")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Enable-TssSecret request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Secrets.ActivateResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.ActivateResult]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
