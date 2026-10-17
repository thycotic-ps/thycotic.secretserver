function Get-TssFolderSyncConfiguration {
    <#
    .SYNOPSIS
    Get the folder synchronization configuration

    .DESCRIPTION
    Get how Secret Server synchronizes folders from ConnectWise: the method, the interval, the folder to synchronize, the connection settings and how long operational logs are kept.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssFolderSyncConfiguration -TssSession $session

    Show the folder synchronization configuration

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssFolderSyncConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssFolderSyncConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.FolderSyncConfiguration')]
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
            $uri = $TssSession.ApiUrl, 'configuration', 'folder-synchronization' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Get-TssFolderSyncConfiguration request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Configuration.FolderSyncConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.FolderSyncConfiguration]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
