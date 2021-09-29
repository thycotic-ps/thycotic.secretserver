function Invoke-TssReport {
    <#
    .SYNOPSIS
    Executes a report, returning the results as a PSCustomObject

    .DESCRIPTION
    Executes a report, returning the results as a PSCustomObject

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssReport -TssSession $session -ReportName GroupMembershipReportByGroup -Parameters @{Group = 1}

    Executes report GroupMembershipReportByGroup returning PSCustomObject result for Everyone group (1)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssReport -TssSession $session -ReportName 'Filter Name' -Parameters @{customtext = 'ada.jupiter.com\brittney.poole - 4073'}

    Executes report "Filter Name" returning PSCustomObject result based on custom text filter

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssReport -TssSession $session -ReportId 60

    Executes report 60 (Changed90DaysReportName) returning PSCustomObject result

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Invoke-TssReport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Invoke-TssReport.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.Object')]
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
        $Parameters
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'reports', 'execute' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'

            $executeBody = @{}
            switch ($tssParams.Keys) {
                'ReportId' { $executeBody.Add('id', [string]$ReportId) }
                'ReportName' { $executeBody.Add('name', $ReportName) }
                'Parameters' {
                    $reportParams = @()
                    foreach ($param in $Parameters.Keys) {
                        $reportParams += [ordered]@{
                            Name = $param
                            Value = $Parameters.$param
                        }
                    }
                    $executeBody.Add('parameters', $reportParams )
                }
            }
            $invokeParams.Body = $executeBody | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue getting report'
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                $results = @()
                foreach ($row in $restResponse.rows) {
                    $reportData = [PSCustomObject]@{ }
                    for ($r = 0;$r -lt $restResponse.columns.Count;$r++) {
                        $reportData.PSObject.Properties.Add([PSNoteProperty]::new($restResponse.columns[$r],$row[$r]))
                    }
                    $results += $reportData
                }
                $results
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}