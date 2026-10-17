function Update-TssEventPipelinePolicyOrder {
    <#
    .SYNOPSIS
    Move an event pipeline policy to a new position

    .DESCRIPTION
    Moves an event pipeline policy to a new position in the policy run order and returns the policy. Positions start at 1.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline policy ID

    .PARAMETER SortOrder
    New position of the policy, starting at 1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssEventPipelinePolicyOrder -TssSession $session -Id 3 -SortOrder 1

    Moves event pipeline policy 3 to the first position

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Update-TssEventPipelinePolicyOrder

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Update-TssEventPipelinePolicyOrder.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EventPipelinePolicy.Policy')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('EventPipelinePolicyId')]
        [int]
        $Id,

        [Parameter(Mandatory)]
        [Alias('NewSortOrder')]
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
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy', $Id, 'order' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ }
            switch ($tssParams.Keys) {
                'SortOrder' {
                    $body.Add('newSortOrder', $SortOrder)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Event pipeline policy order: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssEventPipelinePolicyOrder request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.EventPipelinePolicy.Policy](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.EventPipelinePolicy.Policy]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
