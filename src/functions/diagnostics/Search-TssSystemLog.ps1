function Search-TssSystemLog {
    <#
    .SYNOPSIS
    Search the Secret Server System Log

    .DESCRIPTION
    Search the Secret Server System Log

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/diagnostics/Search-TssSystemLog

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/diagnostics/Search-TssSystemLog.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSystemLog -TssSession $session -SearchText "powershell"

    Return Log messages matching the text "powershell"

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssSystemLog -TssSession $session -SearchText "Azure AD"

    Return Log messages matching the text "Azure AD"

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Diagnostics.SystemLog')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Text to search for in System Log
        [string]
        $SearchText,

        # Log Level to filter on
        [Thycotic.PowerShell.Enums.LogLevel]
        $LogLevel,

        # Sort by specific property, default DateRecorded
        [string]
        $SortBy = 'DateRecorded'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000000' $PSCmdlet.MyInvocation
            $uri = ($TssSession.ApiUrl -replace 'v1','v2'), 'diagnostics', 'system-logs' -join '/'
            $uri = $uri, "sortBy[0].direction=desc&sortBy[0].name=$SortBy&take=$($TssSession.Take)" -join '?'
            $invokeParams.Method = 'GET'

            $filters = @()
            switch ($tssParams.Keys) {
                'SearchText' { $filters += "filter.searchTerm=$SearchText" }
                'LogLevel' { $filters += "filter.logLevel=$LogLevel"}
            }
            if ($filters) {
                $uriFilter = $filters -join '&'
                Write-Verbose "Filters: $uriFilter"
                $uri = $uri, $uriFilter -join '&'
            }
            $invokeParams.Uri = $uri

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue on search request"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.records.Count -le 0 -and $restResponse.records.Length -eq 0) {
                Write-Warning "No messages found in the System Log"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Diagnostics.SystemLog[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}