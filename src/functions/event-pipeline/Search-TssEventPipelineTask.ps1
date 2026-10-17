function Search-TssEventPipelineTask {
    <#
    .SYNOPSIS
    Search event pipeline task definitions

    .DESCRIPTION
    Returns the task definitions event pipelines can run, optionally only those available for one event action.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EventActionId
    Return only the tasks available for this event action (EventActionId from Get-TssEventPipelineTriggerOption)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventPipelineTask -TssSession $session

    Returns all event pipeline task definitions

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssEventPipelineTask -TssSession $session -EventActionId 10044

    Returns the tasks available when access to a secret is approved

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Search-TssEventPipelineTask

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Search-TssEventPipelineTask.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipeline.TaskDefinition[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [int]
        $EventActionId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'event-pipeline-settings', 'task', 'list' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'EventActionId' {
                    $queryParams += "filter.eventActionId=$($EventActionId)"
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
                Write-Warning 'Issue with Search-TssEventPipelineTask request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.EventPipeline.TaskDefinition[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.EventPipeline.TaskDefinition]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
