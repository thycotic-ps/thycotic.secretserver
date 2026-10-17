function Import-TssPbaHistory {
    <#
    .SYNOPSIS
    Import historical events into Privilege Behavior Analytics (PBA)

    .DESCRIPTION
    Sends historical Secret Server events to PBA. With -ProcessImport the server starts the import for the optional StartDate to EndDate window.
    Without -ProcessImport nothing is imported and the call returns the result shape only.
    Use Get-TssPbaImportStatus to watch the backlog.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER ProcessImport
    Start the import. Without it nothing is imported

    .PARAMETER StartDate
    Start of the import window

    .PARAMETER EndDate
    End of the import window

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Import-TssPbaHistory -TssSession $session -ProcessImport -StartDate (Get-Date).AddDays(-7) -EndDate (Get-Date)

    Imports the last 7 days of events into PBA

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Import-TssPbaHistory -TssSession $session -ProcessImport -WhatIf

    Shows the request without sending it

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/pba-configuration/Import-TssPbaHistory

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/pba-configuration/Import-TssPbaHistory.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession

    Requires the Administer Security Analytics permission and a Privilege Behavior Analytics license; otherwise the server returns 403.
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.PbaConfiguration.HistoryImport')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $ProcessImport,

        [datetime]
        $StartDate,

        [datetime]
        $EndDate
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'pba-history-import' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ processImport = [boolean]$ProcessImport }
            switch ($tssParams.Keys) {
                'StartDate' {
                    $body.Add('startDate', $StartDate.ToUniversalTime().ToString('o'))
                }
                'EndDate' {
                    $body.Add('endDate', $EndDate.ToUniversalTime().ToString('o'))
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Pba history", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Import-TssPbaHistory request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.PbaConfiguration.HistoryImport](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.PbaConfiguration.HistoryImport]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
