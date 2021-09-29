function Export-TssReport {
    <#
    .SYNOPSIS
    Export results of a Report to CSV format.

    .DESCRIPTION
    Export results of a Report to CSV format.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Export-TssReport -TssSession $session -ReportName GroupMembershipReportByGroup -Parameters @{Group = 1}

    Exports report GroupMembershipReportByGroup returning CSV formatted result for Everyone group (1)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Export-TssReport -TssSession $session -ReportName 'Filter Name' -Parameters @{customtext = 'ada.jupiter.com\brittney.poole - 4073'}

    Exports report "Filter Name" returning CSV formatted result, based on custom text filter

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Export-TssReport -TssSession $session -ReportId 60 -Delimiter '|'

    Exports report 60 (Changed90DaysReportName) in CSV format, delimited by pipe character ("|")

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Export-TssReport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Export-TssReport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.String')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Report Id
        [Alias("Id")]
        [int]
        $ReportId,

        # Name of Report
        [string]
        $ReportName,

        # Report Parameters provided as hash format of @{<Parameter Name>,<Param Value>} (see examples)
        [System.Collections.Hashtable]
        $Parameters,

        # Delimiter for CSV data, defaults to comma
        [string]
        $Delimiter = ',',

        # Format of export, CSV only supported option at this time
        [ValidateSet('csv')]
        [string]
        $Format = 'csv'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'reports', 'export' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $exportBody = @{}
            switch ($tssParams.Keys) {
                'ReportId' { $exportBody.Add('id', [string]$ReportId) }
                'ReportName' { $exportBody.Add('name', $ReportName) }
                'Parameters' {
                    $reportParams = @()
                    foreach ($param in $Parameters.Keys) {
                        $reportParams += [ordered]@{
                            Name  = $param
                            Value = $Parameters.$param
                        }
                    }
                    $exportBody.Add('parameters', $reportParams )
                }
            }
            if ($Delimiter) {
                $exportBody.Add('delimiter', $Delimiter)
            }
            if ($Format) {
                $exportBody.Add('format', $Format)
            }
            $invokeParams.Body = $exportBody | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue getting report data'
                $err = $_
                . $ErrorHandling $err
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}