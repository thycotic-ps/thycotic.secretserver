function Test-TssSessionRecordingArchive {
    <#
    .SYNOPSIS
    Test the session recording archive location

    .DESCRIPTION
    Tests that Secret Server can write to the configured session recording archive location. Returns Success and the message Secret Server reports.
    Secret Server returns an error (Archiving is not enabled) while session recording archiving is off.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssSessionRecordingArchive -TssSession $session

    Test the configured session recording archive location

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Test-TssSessionRecordingArchive

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Test-TssSessionRecordingArchive.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.SessionRecordingArchiveTest')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'sessionrecording', 'archive', 'test' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssSessionRecordingArchive request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.SessionRecordingArchiveTest](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.SessionRecordingArchiveTest]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
