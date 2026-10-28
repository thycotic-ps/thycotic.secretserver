function Search-TssDirectoryServiceSyncLog {
    <#
    .SYNOPSIS
    Search the Directory Services synchronization log

    .DESCRIPTION
    Search the directory synchronization log: when each entry was written, by which machine, and the message. Without -StartDate the server returns the last five days.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EndDate
    Latest entry date; the server default is now

    .PARAMETER SearchText
    Text to match in the log message

    .PARAMETER StartDate
    Earliest entry date; the server default is five days ago

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceSyncLog -TssSession $session -StartDate (Get-Date).AddDays(-1)

    Show the synchronization log of the last day

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssDirectoryServiceSyncLog -TssSession $session -SearchText error

    Find synchronization log entries that mention error

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/directory-services/Search-TssDirectoryServiceSyncLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/directory-services/Search-TssDirectoryServiceSyncLog.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.DirectoryServices.SyncLog[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [datetime]
        $EndDate,

        [string]
        $SearchText,

        [datetime]
        $StartDate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'directory-services', 'synchronization', 'logs' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'EndDate' {
                    $queryParams += "filter.endDate=$([uri]::EscapeDataString($EndDate.ToString('o')))"
                }
                'SearchText' {
                    $queryParams += "filter.searchText=$([uri]::EscapeDataString($SearchText))"
                }
                'StartDate' {
                    $queryParams += "filter.startDate=$([uri]::EscapeDataString($StartDate.ToString('o')))"
                }
            }
            if ($queryParams) {
                $uri = $uri, ($queryParams -join '&') -join '?'
            }
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Search-TssDirectoryServiceSyncLog request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.DirectoryServices.SyncLog[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.DirectoryServices.SyncLog]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
