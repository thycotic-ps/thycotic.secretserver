function Get-TssListAudit {
    <#
    .SYNOPSIS
    Get the audit trail of a list

    .DESCRIPTION
    Returns one entry per change made to a list or its options: who made it, when, the action, and any notes.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Categorized List ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssListAudit -TssSession $session -Id 'df0b8746-581f-4ac2-a9b2-5a2b7a679f3e'

    Returns the audit entries for the list with the given ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssList -TssSession $session -SearchText 'Servers' | Get-TssListAudit -TssSession $session

    Returns the audit entries for every list with "Servers" in the name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/lists/Get-TssListAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/lists/Get-TssListAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Lists.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('CategorizedListId')]
        [string[]]
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
                $uri = $TssSession.ApiUrl, 'lists', $currentId, 'audits' -join '/'
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
                    Write-Warning 'Issue with Get-TssListAudit request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.Lists.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.Lists.Audit]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
