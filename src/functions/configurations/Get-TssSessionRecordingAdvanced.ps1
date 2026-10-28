function Get-TssSessionRecordingAdvanced {
    <#
    .SYNOPSIS
    Get the advanced session recording configuration

    .DESCRIPTION
    Returns the Advanced Session Recording settings: whether advanced session recording is enabled and the callback URL the session recording agent reports to.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSessionRecordingAdvanced -TssSession $session

    Get the advanced session recording configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssSessionRecordingAdvanced

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssSessionRecordingAdvanced.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.SessionRecordingAdvanced')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'sessionrecording-advanced' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssSessionRecordingAdvanced request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.SessionRecordingAdvanced](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SessionRecordingAdvanced]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
