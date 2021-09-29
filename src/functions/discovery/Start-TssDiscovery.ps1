function Start-TssDiscovery {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/discovery/Start-TssSecretHearbeat

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/discovery/Start-TssSecretHearbeat.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret Id
        [Parameter(Mandatory, Position = 1)]
        [ValidateSet('Discovery', 'ComputerScan')]
        [string]
        $Type
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
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
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
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