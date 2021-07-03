function Get-ReportParameter {
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
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssReportParameter

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/reports/Get-ReportParameter.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssReportParameter')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Report ID
        [Parameter(Mandatory)]
        [Alias("ReportId")]
        [int]
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
            $restResponse = $null
            $uri = $TssSession.ApiUrl, 'reports', $Id, 'defaultparameters' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $uri with $body"
            try {
                $restResponse = . $InvokeApi @invokeParams
            } catch {
                Write-Warning "Issue getting parameters for report [$Id]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse.defaultParameterValues) {
                [TssReportParameter[]]$restResponse.defaultParameterValues
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}