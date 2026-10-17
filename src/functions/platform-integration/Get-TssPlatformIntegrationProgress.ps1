function Get-TssPlatformIntegrationProgress {
    <#
    .SYNOPSIS
    Get the progress of each Delinea Platform data integration step

    .DESCRIPTION
    Returns one object per step of the Delinea Platform data integration (onboarding) sequence, with its status and start and end dates.
    By default steps are identified by number (Step, v1 endpoint). With -ByStepType steps are identified by name (StepType, v2 endpoint), for example OptIn, SecureAccess, Domains or SyncData.
    Requires Delinea Platform integration on the Secret Server instance; without it the server returns an error (API_PlatformNotEnabled).

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ByStepType
    Identify the steps by name (StepType) using the v2 endpoint instead of by number

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformIntegrationProgress -TssSession $session

    Returns the status of each integration step, identified by step number

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssPlatformIntegrationProgress -TssSession $session -ByStepType | Where-Object Status -ne 'Complete'

    Returns the integration steps that are not complete, identified by step name

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/platform-integration/Get-TssPlatformIntegrationProgress

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/platform-integration/Get-TssPlatformIntegrationProgress.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'Default')]
    [OutputType('Thycotic.PowerShell.PlatformIntegration.IntegrationStep[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ParameterSetName = 'ByStepType')]
        [switch]
        $ByStepType
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
                'ByStepType' {
                    $uri = ($TssSession.ApiUrl -replace 'v1','v2'), 'platform-integration', 'integration-progress' -join '/'
                }
                default {
                    $uri = $TssSession.ApiUrl, 'platform-integration', 'integration-progress' -join '/'
                }
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssPlatformIntegrationProgress request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.steps) {
                [Thycotic.PowerShell.PlatformIntegration.IntegrationStep[]](. $FilterTssResponse $restResponse.steps ([Thycotic.PowerShell.PlatformIntegration.IntegrationStep]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
