function Update-TssEventPipelinePolicy {
    <#
    .SYNOPSIS
    Update an event pipeline policy

    .DESCRIPTION
    Updates the name, description or active state of an event pipeline policy. Only the parameters provided are changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Event pipeline policy ID

    .PARAMETER Name
    New event pipeline policy name

    .PARAMETER Description
    New event pipeline policy description

    .PARAMETER Active
    Set the policy active (-Active) or inactive (-Active:$false)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssEventPipelinePolicy -TssSession $session -Id 3 -Name 'Secret approvals (all)'

    Renames event pipeline policy 3

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssEventPipelinePolicy -TssSession $session -Id 3 -Active:$false

    Deactivates event pipeline policy 3

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/event-pipeline-policies/Update-TssEventPipelinePolicy

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/event-pipeline-policy/Update-TssEventPipelinePolicy.ps1

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

        [Alias('EventPipelinePolicyName')]
        [string]
        $Name,

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
            $uri = $TssSession.ApiUrl, 'event-pipeline-policy', $Id -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Name' {
                    $body.data.Add('eventPipelinePolicyName', @{ dirty = $true; value = $Name })
                }
                'Description' {
                    $body.data.Add('eventPipelinePolicyDescription', @{ dirty = $true; value = $Description })
                }
                'Active' {
                    $body.data.Add('active', @{ dirty = $true; value = [boolean]$Active })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Event pipeline policy: $Id", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssEventPipelinePolicy request'
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
