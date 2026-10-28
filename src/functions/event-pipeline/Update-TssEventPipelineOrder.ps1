function Update-TssEventPipelineOrder {
    <#
    .SYNOPSIS
    Move an event pipeline within its event pipeline policy

    .DESCRIPTION
    Moves an event pipeline to a new position in an event pipeline policy and returns the policy pipeline order after the move. Positions start at 1.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline ID

    .PARAMETER EventPipelinePolicyId
    Event pipeline policy the pipeline belongs to

    .PARAMETER SortOrder
    New position of the pipeline in the policy, starting at 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssEventPipelineOrder -TssSession $session -Id 12 -EventPipelinePolicyId 3 -SortOrder 1

    Moves pipeline 12 to the first position in policy 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipelines/Update-TssEventPipelineOrder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline/Update-TssEventPipelineOrder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EventPipeline.PolicyMap[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelineId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [Alias('PolicyId')]
        [int]
        $EventPipelinePolicyId,

        [Parameter(Mandatory)]
        [int]
        $SortOrder
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'event-pipeline', $Id, 'order' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'EventPipelinePolicyId' {
                    $body.data.Add('eventPipelinePolicyId', $EventPipelinePolicyId)
                }
                'SortOrder' {
                    $body.data.Add('sortOrder', @{ dirty = $true; value = $SortOrder })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Event pipeline order: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssEventPipelineOrder request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.EventPipeline.PolicyMap[]](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventPipeline.PolicyMap]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
