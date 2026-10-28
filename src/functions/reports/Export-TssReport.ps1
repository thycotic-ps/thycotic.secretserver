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

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Export-TssReport -TssSession $session -ReportId 60 -Download

    Streams report 60 as CSV through the download endpoint

    .PARAMETER Download
    Stream the report as CSV instead of exporting it. Requires ReportId; ReportName and Delimiter do not apply. Secret Server streams only some reports this way.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Export-TssReport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Export-TssReport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'export')]
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
        $Format = 'csv',

        [Parameter(Mandatory, ParameterSetName = 'download')]
        [switch]
        $Download
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if ($PSCmdlet.ParameterSetName -eq 'download') {
                if (-not $tssParams.ContainsKey('ReportId')) {
                    Write-Error 'Download requires ReportId'
                    return
                }
                $uri = $TssSession.ApiUrl, 'reports', 'download-csv' -join '/'
                $queryParams = @("reportId=$ReportId")
                $parameterIndex = 0
                foreach ($param in $Parameters.Keys) {
                    $queryParams += "parameters[$parameterIndex].name=$([uri]::EscapeDataString([string]$param))"
                    $queryParams += "parameters[$parameterIndex].value=$([uri]::EscapeDataString([string]$Parameters.$param))"
                    $parameterIndex++
                }
                $invokeParams.Uri = $uri, ($queryParams -join '&') -join '?'
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue downloading report data'
                    $err = $_
                    . $ErrorHandling $err
                }
                return
            }
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