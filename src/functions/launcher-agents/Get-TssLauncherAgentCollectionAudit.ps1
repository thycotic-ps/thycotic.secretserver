function Get-TssLauncherAgentCollectionAudit {
    <#
    .SYNOPSIS
    Get launcher agent collection audits

    .DESCRIPTION
    Get the audit records of every launcher agent collection, or of one collection with -Id.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Launcher agent collection Id. Omit to get the audit records of every collection

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssLauncherAgentCollectionAudit -TssSession $session

    Get the audit records of every launcher agent collection

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssLauncherAgentCollectionAudit -TssSession $session -Id 1

    Get the audit records of launcher agent collection 1

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/launcher-agents/Get-TssLauncherAgentCollectionAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/launcher-agents/Get-TssLauncherAgentCollectionAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'all')]
    [OutputType('Thycotic.PowerShell.LauncherAgents.CollectionAudit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'collection')]
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
            $uris = [System.Collections.Generic.List[string]]::new()
            if ($PSCmdlet.ParameterSetName -eq 'collection') {
                foreach ($currentId in $Id) {
                    $uri = $TssSession.ApiUrl, 'launcheragents', 'collections', $currentId, 'audit' -join '/'
                    $uris.Add($uri)
                }
            } else {
                $uri = $TssSession.ApiUrl, 'launcheragents', 'collections', 'audit' -join '/'
                $uris.Add($uri)
            }
            foreach ($currentUri in $uris) {
                $restResponse = $null
                $invokeParams.Uri = $currentUri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $currentUri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssLauncherAgentCollectionAudit request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.LauncherAgents.CollectionAudit[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.LauncherAgents.CollectionAudit]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
