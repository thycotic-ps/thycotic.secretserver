function Get-TssEventPipelineTriggerOption {
    <#
    .SYNOPSIS
    Get the triggers available to event pipelines

    .DESCRIPTION
    Returns the event actions that can trigger an event pipeline for an entity type. EventActionId is the value for the TriggerActionId parameter of New-TssEventPipeline and Update-TssEventPipeline.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EventEntityType
    Entity type the options apply to, such as Secret, User or Group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelineTriggerOption -TssSession $session -EventEntityType Secret | Where-Object TriggerDisplayName -like '*approved*'

    Returns the secret triggers that fire on an approval

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineTriggerOption

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineTriggerOption.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipeline.TriggerView[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('EventEntityTypeId')]
        [Thycotic.PowerShell.Enums.EventEntityType]
        $EventEntityType
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'event-pipeline', 'trigger', 'options' -join '/'
            $queryParams = @()
            switch ($tssParams.Keys) {
                'EventEntityType' {
                    $queryParams += "eventEntityTypeId=$([int]$EventEntityType)"
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
                Write-Warning 'Issue with Get-TssEventPipelineTriggerOption request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.EventPipeline.TriggerView[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventPipeline.TriggerView]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
