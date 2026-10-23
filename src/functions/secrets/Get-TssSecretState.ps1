function Get-TssSecretState {
    <#
    .SYNOPSIS
    Get details on state of the Secret

    .DESCRIPTION
    Get details on state (requires checkout, restricted actions, etc) of the Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretState -TssSession $session -Id 42

    Add minimum example for each parameter

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretState -TssSession $session -Id 42 -Flags

    Returns the heartbeat status, password change state and password compliance of secret 42

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretState -TssSession $session -Id 42 -FlagsV2

    Returns the state flags of secret 42 from the v2 endpoint, where PasswordChangeState can also be PreRunValidationFailed

    .PARAMETER Flags
    Return the state flags (heartbeat status, password change state, password compliance) instead of the state details

    .PARAMETER FlagsV2
    Return the state flags from the v2 endpoint, which adds PreRunValidationFailed to PasswordChangeState

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretState

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretState.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'state')]
    [OutputType('Thycotic.PowerShell.Secrets.DetailState')]
    [OutputType('Thycotic.PowerShell.Secrets.StateFlags', ParameterSetName = ('flags', 'flagsV2'))]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 1)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        [Parameter(Mandatory, ParameterSetName = 'flags')]
        [switch]
        $Flags,

        [Parameter(Mandatory, ParameterSetName = 'flagsV2')]
        [switch]
        $FlagsV2
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                if ($PSCmdlet.ParameterSetName -ne 'state') {
                    switch ($PSCmdlet.ParameterSetName) {
                        'flagsV2' {
                            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'secrets', $secret, 'state', 'flags' -join '/'
                        }
                        default {
                            $uri = $TssSession.ApiUrl, 'secrets', $secret, 'state', 'flags' -join '/'
                        }
                    }
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'

                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue getting state flags for secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Secrets.StateFlags](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.StateFlags]))
                    }
                    continue
                }
                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'state' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting state for secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.Secrets.DetailState](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.DetailState]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}