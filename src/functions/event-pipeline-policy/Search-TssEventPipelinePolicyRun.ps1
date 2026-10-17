function Search-TssEventPipelinePolicyRun {
    <#
    .SYNOPSIS
    Search event pipeline policy runs

    .DESCRIPTION
    Returns the runs of event pipeline policies, newest first, filtered by the parameters given.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EntityTypeName
    Entity type name, such as Secret or User

    .PARAMETER EventDateFrom
    Return runs for events on or after this date

    .PARAMETER EventDateTo
    Return runs for events on or before this date

    .PARAMETER EventPipelinePolicyId
    Event pipeline policy ID

    .PARAMETER EventPipelinePolicyRunId
    Event pipeline policy run ID (a GUID)

    .PARAMETER ItemName
    Name of the item (secret, user, group) the event was about

    .PARAMETER PipelineName
    Event pipeline name

    .PARAMETER PolicyName
    Event pipeline policy name

    .PARAMETER Status
    Run status, such as Queued, Running, Completed or Failed

    .PARAMETER TriggerName
    Trigger (event action) name

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventPipelinePolicyRun -TssSession $session -EventPipelinePolicyId 3

    Returns the runs of event pipeline policy 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventPipelinePolicyRun -TssSession $session -Status Failed -EventDateFrom (Get-Date).AddDays(-1)

    Returns the failed runs of the last day

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Search-TssEventPipelinePolicyRun

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Search-TssEventPipelinePolicyRun.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipelinePolicy.Run[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $EntityTypeName,

        [datetime]
        $EventDateFrom,

        [datetime]
        $EventDateTo,

        [Alias('PolicyId')]
        [int]
        $EventPipelinePolicyId,

        [string]
        $EventPipelinePolicyRunId,

        [string]
        $ItemName,

        [string]
        $PipelineName,

        [string]
        $PolicyName,

        [string]
        $Status,

        [string]
        $TriggerName
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy', 'runs' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'EntityTypeName' {
                    $queryParams += "filter.entityTypeName=$([uri]::EscapeDataString($EntityTypeName))"
                }
                'EventDateFrom' {
                    $queryParams += "filter.eventDateFrom=$([uri]::EscapeDataString($EventDateFrom.ToString('o')))"
                }
                'EventDateTo' {
                    $queryParams += "filter.eventDateTo=$([uri]::EscapeDataString($EventDateTo.ToString('o')))"
                }
                'EventPipelinePolicyId' {
                    $queryParams += "filter.eventPipelinePolicyId=$($EventPipelinePolicyId)"
                }
                'EventPipelinePolicyRunId' {
                    $queryParams += "filter.eventPipelinePolicyRunId=$([uri]::EscapeDataString($EventPipelinePolicyRunId))"
                }
                'ItemName' {
                    $queryParams += "filter.itemName=$([uri]::EscapeDataString($ItemName))"
                }
                'PipelineName' {
                    $queryParams += "filter.pipelineName=$([uri]::EscapeDataString($PipelineName))"
                }
                'PolicyName' {
                    $queryParams += "filter.policyName=$([uri]::EscapeDataString($PolicyName))"
                }
                'Status' {
                    $queryParams += "filter.status=$([uri]::EscapeDataString($Status))"
                }
                'TriggerName' {
                    $queryParams += "filter.triggerName=$([uri]::EscapeDataString($TriggerName))"
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
                Write-Warning 'Issue with Search-TssEventPipelinePolicyRun request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.EventPipelinePolicy.Run[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.EventPipelinePolicy.Run]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
