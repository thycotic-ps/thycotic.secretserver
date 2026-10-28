function Get-TssUnlimitedAdminAudit {
    <#
    .SYNOPSIS
    Get the Unlimited Admin Mode audit log

    .DESCRIPTION
    Returns the audit entries for Unlimited Admin Mode: who enabled or disabled it, when, and the note they gave.
    Entries are returned oldest first.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUnlimitedAdminAudit -TssSession $session

    Returns every Unlimited Admin Mode audit entry, oldest first

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssUnlimitedAdminAudit -TssSession $session | Select-Object -Last 5

    Returns the five most recent Unlimited Admin Mode changes

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssUnlimitedAdminAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssUnlimitedAdminAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.UnlimitedAdminAudit[]')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'unlimited-admin', 'audit' -join '/'
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
                Write-Warning 'Issue with Get-TssUnlimitedAdminAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Configuration.UnlimitedAdminAudit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Configuration.UnlimitedAdminAudit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
