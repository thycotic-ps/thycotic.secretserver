function Get-TssEventPipelinePolicyActivity {
    <#
    .SYNOPSIS
    Get all activity for a specific Event Policy run

    .DESCRIPTION
    Get all activity for a specific Event Policy run

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipeline -TssSession $session -Id 20 | Get-TssEventPipelinePolicyActivity -TssSession $session

    Output all activity for Event Pipeline ID 20.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssEventPipelinePolicyActivity -TssSession $session -PipelineId 20 -RunId '6ff82b0a-7ecb-457a-a31b-43d5982570bf'

    Output the activity for Event Pipeline ID 20 and the noted Run ID GUID.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policy/Get-TssEventPipelinePolicyActivity

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Get-TssEventPipelinePolicyActivity.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.EventPipelinePolicy.Activity')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Event Pipeline ID
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias("EventPipelineId")]
        [int]
        $PipelineId,

        # Event Pipeline Policy Run ID
        [Parameter(Mandatory,ValueFromPipeline,ValueFromPipelineByPropertyName)]
        [Alias('EventPipelinePolicyRunId')]
        [string]
        $RunId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy', 'activity' -join '/'
            $uri = $uri, "eventPipelineId=$PipelineId&eventPipelinePolicyRunId=$RunId" -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting activity for Event Pipeline [$Id]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                [Thycotic.PowerShell.EventPipelinePolicy.Activity[]]$restResponse
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}