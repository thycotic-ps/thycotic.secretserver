function Start-TssActiveDirectorySync {
    <#
    .SYNOPSIS
    Start the Active Directory group and user synchronization

    .DESCRIPTION
    Queue the Active Directory synchronization, which updates the members of every directory group that has synchronization enabled. Returns True when the run is queued.
    The server answers 400 API_ADConfigDisabled when directory integration or directory synchronization is disabled (see Get-TssDirectoryConfiguration). Start-TssDirectoryServiceSync queues the same background synchronization through the directory-services endpoint.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Start-TssActiveDirectorySync -TssSession $session

    Queue the Active Directory synchronization

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/active-directory/Start-TssActiveDirectorySync

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/active-directory/Start-TssActiveDirectorySync.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the Administer Active Directory permission.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('System.Boolean')]
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
            $uri = $TssSession.ApiUrl, 'active-directory', 'synchronize' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            if ($PSCmdlet.ShouldProcess("Active directory sync", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Start-TssActiveDirectorySync request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
[System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
