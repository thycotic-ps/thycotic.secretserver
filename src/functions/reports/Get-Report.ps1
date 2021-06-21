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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReport

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-Report.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssReport')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [TssSession]
        $TssSession,

        # Report ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('ReportId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($report in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'reports', $report -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                Write-Verbose "$($invokeParams.Method) $uri"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting report [$report]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssReport]$restResponse
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}