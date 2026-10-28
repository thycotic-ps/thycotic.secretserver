function Get-TssEventPipelineFilterOption {
    <#
    .SYNOPSIS
    Get the filters available to event pipelines

    .DESCRIPTION
    Returns the filter definitions an event pipeline can use for an entity type. EventPipelineFilterId and EventPipelineFilterName identify a filter for New-TssEventPipeline and Update-TssEventPipeline.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EventEntityType
    Entity type the options apply to, such as Secret, User or Group

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelineFilterOption -TssSession $session -EventEntityType Secret

    Returns the filters available to secret event pipelines

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineFilterOption

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineFilterOption.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipeline.FilterOption[]')]
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
            $uri = $TssSession.ApiUrl, 'event-pipeline-settings', 'filter', 'options' -join '/'
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
                Write-Warning 'Issue with Get-TssEventPipelineFilterOption request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.EventPipeline.FilterOption[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventPipeline.FilterOption]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
