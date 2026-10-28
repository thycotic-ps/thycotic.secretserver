function Get-TssMdiIntegrationAudit {
    <#
    .SYNOPSIS
    Get the audit of the MDI integration configuration

    .DESCRIPTION
    Get the audit records of changes to the Microsoft Defender for Identity (MDI) integration configuration.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssMdiIntegrationAudit -TssSession $session

    List the MDI integration configuration audit

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssMdiIntegrationAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssMdiIntegrationAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Secret Server Cloud only: an on-premises Secret Server answers this endpoint with Access denied.
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.Audit[]')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'mdi-integration-audits' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
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
                Write-Warning 'Issue with Get-TssMdiIntegrationAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Configuration.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Configuration.Audit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
