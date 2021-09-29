function Get-TssDirectoryServiceSyncStatus {
    <#
    .SYNOPSIS
    Get status of the Directory Services synchronization

    .DESCRIPTION
    Get status of the Directory Services synchronization

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssDirectoryServiceSyncStatus -TssSession $session

    Return status of the directory service synchronization

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Get-TssDirectoryServiceSyncStatus

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Get-TssDirectoryServiceSyncStatus.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DirectoryServices.SyncStatus')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
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
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
                $uri = $TssSession.ApiUrl, 'directory-services', 'synchronization' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting Directory Services synchronization status"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [Thycotic.PowerShell.DirectoryServices.SyncStatus]$restResponse
                }
        } else {
            Write-Warning "No valid session found"
        }
    }
}