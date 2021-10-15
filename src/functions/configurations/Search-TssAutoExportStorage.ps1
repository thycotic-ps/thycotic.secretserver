function Search-TssAutoExportStorage {
    <#
    .SYNOPSIS
    Search list of items in Automatic Export Storage for Secret Server Cloud

    .DESCRIPTION
    Search list of items in Automatic Export Storage for Secret Server Cloud

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Search-TssAutoExportStorage

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Search-TssAutoExportStorage.ps1

    .EXAMPLE
    $session = New-TssSession -SecretServer https://tenant.secretservecloud.com -Credential $ssCred
    Search-TssAutoExportStorage -TssSession $session

    Returns a list of items in Automatic Export Storage

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.AutomaticExportItem')]
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
        try { Compare-TssUrl $TssSession } catch { throw $_ }
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.0.000005' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'auto-export-storage' -join '/'
            $uri = $uri, "sortBy[0].direction=desc&sortBy[0].name=Id&take=$($TssSession.Take)" -join '?'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

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
                Write-Warning "No AutomaticStorage found"
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.Configuration.AutomaticExportItem[]]$restResponse.records
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}