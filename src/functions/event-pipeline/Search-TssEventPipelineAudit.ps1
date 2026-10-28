function Search-TssEventPipelineAudit {
    <#
    .SYNOPSIS
    Search event pipeline and event pipeline policy audit entries

    .DESCRIPTION
    Returns the audit trail of event pipelines and event pipeline policies, newest changes included.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventPipelineAudit -TssSession $session

    Returns all event pipeline and policy audit entries

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Search-TssEventPipelineAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Search-TssEventPipelineAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipeline.Audit[]')]
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
            $uri = $TssSession.ApiUrl, 'event-pipeline-audit' -join '/'
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
                Write-Warning 'Issue with Search-TssEventPipelineAudit request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.EventPipeline.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.EventPipeline.Audit]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
