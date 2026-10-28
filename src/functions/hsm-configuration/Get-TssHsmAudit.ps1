function Get-TssHsmAudit {
    <#
    .SYNOPSIS
    Get the HSM configuration audit trail

    .DESCRIPTION
    Gets the audit records of Hardware Security Module (HSM) configuration changes: who changed the HSM settings, what was done and when.
    Requires the View HSM or Administer HSM role permission.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssHsmAudit -TssSession $session

    Get the HSM configuration audit trail

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/hsm-configuration/Get-TssHsmAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/hsm-configuration/Get-TssHsmAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.HsmConfiguration.HsmAudit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'hsm-configuration', 'audit' -join '/'
            $uri = $uri, "take=$($TssSession.Take)" -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssHsmAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                foreach ($record in $restResponse.records) {
                    [Thycotic.PowerShell.HsmConfiguration.HsmAudit]@{
                        Action                  = $record.action.value
                        Date                    = $record.date.value
                        DateTime                = $record.dateTime.value
                        DisplayName             = $record.displayName.value
                        HsmConfigurationAuditId = $record.hsmConfigurationAuditId.value
                        Notes                   = $record.notes.value
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
