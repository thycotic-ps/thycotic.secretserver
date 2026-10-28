function Set-TssPlatformIntegrationStep {
    <#
    .SYNOPSIS
    Set the status of a Delinea Platform data integration step

    .DESCRIPTION
    Sets the status, and optionally the start and end dates, of one step of the Delinea Platform data integration sequence.
    Identify the step by number with -Step (v1 endpoint) or by name with -StepType (v2 endpoint). Only the parameters you pass are changed.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Step
    Step number to update (v1 endpoint), as returned by Get-TssPlatformIntegrationProgress

    .PARAMETER StepType
    Step name to update (v2 endpoint), as returned by Get-TssPlatformIntegrationProgress -ByStepType

    .PARAMETER Status
    Status to apply to the step

    .PARAMETER StartDate
    Start date to record for the step

    .PARAMETER EndDate
    End date to record for the step

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssPlatformIntegrationStep -TssSession $session -StepType SecureAccess -Status Complete -EndDate (Get-Date)

    Marks the SecureAccess step complete and records now as its end date

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssPlatformIntegrationStep -TssSession $session -Step 2 -Status Skipped

    Marks step 2 as skipped using the v1 endpoint

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Set-TssPlatformIntegrationStep

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Set-TssPlatformIntegrationStep.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Returns True or False (the success flag of the response).
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default', SupportsShouldProcess)]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ParameterSetName = 'Default')]
        [int]
        $Step,

        [Parameter(Mandatory, ParameterSetName = 'StepType')]
        [ValidateSet('OptIn', 'SecureAccess', 'CustomizeBranding', 'Domains', 'Federations', 'SyncData', 'UnifiedMode', 'EntraId', 'TeamsWarning')]
        [string]
        $StepType,

        [Parameter(Mandatory, ParameterSetName = 'Default')]
        [Parameter(Mandatory, ParameterSetName = 'StepType')]
        [ValidateSet('Pending', 'Skipped', 'Complete', 'Error', 'ReadyToStart', 'InProgress', 'Started')]
        [string]
        $Status,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'StepType')]
        [datetime]
        $StartDate,

        [Parameter(ParameterSetName = 'Default')]
        [Parameter(ParameterSetName = 'StepType')]
        [datetime]
        $EndDate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            switch ($PSCmdlet.ParameterSetName) {
                'StepType' {
                    $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'platform-integration', 'update-step' -join '/'
                    $body = @{ data = @{ } }
                    switch ($tssParams.Keys) {
                        'StepType' {
                            $body.data.Add('stepType', $StepType)
                        }
                        'Status' {
                            $body.data.Add('status', @{ dirty = $true; value = $Status })
                        }
                        'StartDate' {
                            $body.data.Add('startDate', @{ dirty = $true; value = $StartDate })
                        }
                        'EndDate' {
                            $body.data.Add('endDate', @{ dirty = $true; value = $EndDate })
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
                default {
                    $uri = $TssSession.ApiUrl, 'platform-integration', 'update-step' -join '/'
                    $body = @{ data = @{ } }
                    switch ($tssParams.Keys) {
                        'Step' {
                            $body.data.Add('step', $Step)
                        }
                        'Status' {
                            $body.data.Add('status', @{ dirty = $true; value = $Status })
                        }
                        'StartDate' {
                            $body.data.Add('startDate', @{ dirty = $true; value = $StartDate })
                        }
                        'EndDate' {
                            $body.data.Add('endDate', @{ dirty = $true; value = $EndDate })
                        }
                    }
                    $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            if ($PSCmdlet.ShouldProcess("Platform integration step", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssPlatformIntegrationStep request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse.success)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
