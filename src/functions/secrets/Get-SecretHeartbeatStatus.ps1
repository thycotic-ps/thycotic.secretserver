function Get-SecretHeartbeatStatus {
    <#
    .SYNOPSIS
    Get a Secret's Heartbeat status

    .DESCRIPTION
    Get a Secret's Heartbeat status

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretHeartbeatStatus -TssSession $session -Id 42

    Returns heartbeat status of Secret 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecretHeartbeatStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-SecretHeartbeatStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssSecretHeartbeatStatus')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret Id
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        . $InternalEndpointUsed $PSCmdlet.MyInvocation
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl.Replace('api/v1', 'internals'), 'secret-detail', $secret, 'heartbeat-status' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting heartbeat status on Secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($null -eq $restResponse.LastHeartbeatCheck) {
                    $restResponse.lastHeartbeatCheck = [datetime]::MinValue
                }

                if ($restResponse) {
                    [TssSecretHeartbeatStatus]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}