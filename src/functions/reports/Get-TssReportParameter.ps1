function Get-TssReportParameter {
    <#
    .SYNOPSIS
    Get default report parameters.

    .DESCRIPTION
    Get default report parameters.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReportParameter -TssSession $session -Id 34

    Get report parameters for Report 34.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/reports/Get-TssReportParameter

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-TssReportParameter.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Reports.Parameter')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Report ID
        [Parameter(Mandatory)]
        [Alias("ReportId")]
        [int]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'reports', $Id, 'defaultparameters' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting parameters for report [$Id]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.defaultParameterValues) {
                [Thycotic.PowerShell.Reports.Parameter[]]$restResponse.defaultParameterValues
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}