function Get-TssEventPipelineFilterSetting {
    <#
    .SYNOPSIS
    Get the settings of an event pipeline filter

    .DESCRIPTION
    Returns the settings a filter definition takes, with their default values. Setting.SettingName is the key to use in the Settings hashtable of a New-TssEventPipeline or Update-TssEventPipeline filter.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline filter ID (EventPipelineFilterId from Get-TssEventPipelineFilterOption)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelineFilterSetting -TssSession $session -Id 6

    Returns the settings of filter 6

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelineFilterOption -TssSession $session -EventEntityType Secret | Where-Object EventPipelineFilterName -eq 'Variable' | Get-TssEventPipelineFilterSetting -TssSession $session

    Returns the settings of the Variable filter

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Get-TssEventPipelineFilterSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Get-TssEventPipelineFilterSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipeline.FilterSettingMap[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelineFilterId')]
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
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'event-pipeline-settings', 'filter-settings', 'list', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssEventPipelineFilterSetting request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.EventPipeline.FilterSettingMap[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventPipeline.FilterSettingMap]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
