function Start-Discovery {
    <#
    .SYNOPSIS
    Start Discovery processing

    .DESCRIPTION
    Start Discovery processing

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssDiscovery -TssSession $session -Type ComputerScan

    Run Discovery Computer Scan

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssDiscovery -TssSession $session -Type Discovery

    Run Discovery Scan

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Start-TssSecretHearbeat

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Start-SecretHearbeat.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Secret Id
        [Parameter(Mandatory, Position = 1)]
        [ValidateSet('Discovery', 'ComputerScan')]
        [string]
        $Type
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'discovery', 'run' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $discoverBody = @{
                data = @{
                    commandType = $Type
                }
            }
            $invokeParams.Body = $discoverBody | ConvertTo-Json
            if (-not $PSCmdlet.ShouldProcess("SecretId: $user", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) { return }
            Write-Verbose "Performing the operation: $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                Write-Verbose "Discovery type [$Type] started"
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}