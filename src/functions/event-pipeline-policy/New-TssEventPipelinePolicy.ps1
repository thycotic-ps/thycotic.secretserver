function New-TssEventPipelinePolicy {
    <#
    .SYNOPSIS
    Create a new event pipeline policy

    .DESCRIPTION
    Creates an empty event pipeline policy for an entity type. Add pipelines with New-TssEventPipeline or Add-TssEventPipeline.
    Without -Active the policy is created inactive.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Name
    Event pipeline policy name

    .PARAMETER EventEntityType
    Entity type the policy acts on, such as Secret, User or Group

    .PARAMETER Description
    Event pipeline policy description

    .PARAMETER Active
    Create the policy active. Without it the policy is created inactive

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    New-TssEventPipelinePolicy -TssSession $session -Name 'Secret approvals' -EventEntityType Secret -Description 'Pipelines for approval events' -Active

    Creates an active secret event pipeline policy

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/New-TssEventPipelinePolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/New-TssEventPipelinePolicy.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.EventPipelinePolicy.Policy')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('EventPipelinePolicyName')]
        [string]
        $Name,

        [Parameter(Mandatory)]
        [Alias('EventEntityTypeId')]
        [Thycotic.PowerShell.Enums.EventEntityType]
        $EventEntityType,

        [Alias('EventPipelinePolicyDescription')]
        [string]
        $Description,

        [switch]
        $Active
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ active = @{ dirty = $true; value = [boolean]$Active } } }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.data.Add('eventPipelinePolicyName', @{ dirty = $true; value = $Name })
                }
                'EventEntityType' {
                    $body.data.Add('eventEntityTypeId', @{ dirty = $true; value = [int]$EventEntityType })
                }
                'Description' {
                    $body.data.Add('eventPipelinePolicyDescription', @{ dirty = $true; value = $Description })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Event pipeline policy", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with New-TssEventPipelinePolicy request'
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
