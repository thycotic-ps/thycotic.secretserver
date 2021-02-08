function Get-Report {
    <#
    .SYNOPSIS
    Gets a report

    .DESCRIPTION
    Gets a report based on Report ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReport -TssSession $session -Id 6

    Gets the details on report ID 6

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssReport

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssReport')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Short description for parameter
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("ReportId")]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($report in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'reports', $report.ToString() -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                Write-Verbose "$($invokeParams.Method) $uri"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue getting report [$report]"
                    $err = $_.ErrorDetails.Message
                    Write-Error $err
                }

                if ($restResponse) {
                    . $TssReportObject $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}