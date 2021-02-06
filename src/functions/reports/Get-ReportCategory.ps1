function Get-ReportCategory {
    <#
    .SYNOPSIS
    Get report categories

    .DESCRIPTION
    Get a report category by Id or list all

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReportCategory -TssSession $session -Id 26

    Returns Report Category details for 26

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssReportCategory -TssSession $session

    Returns a list of all categories

    .LINK
    https://thycotic.secretserver.github.io/commands/Get-TssReportCategory

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('TssReportCategory')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Report Category Id, returns all if not provided
        [Parameter(ValueFromPipelineByPropertyName)]
        [Alias('ReportCategoryId')]
        [int[]]
        $Id,

        # Return list of all categories
        [Parameter()]
        [switch]
        $All
    )
    begin {
        $tssReportCatParams = $PSBoundParameters
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssReportCatParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            if ($tssReportCatParams['Id']) {
                foreach ($reportCategory in $Id) {
                    $restResponse = $null
                    $uri = $TssSession.ApiUrl, 'reports/categories', $reportCategory.ToString() -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'

                    $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                    Write-Verbose "$($invokeParams.Method) $uri"
                    try {
                        $restResponse = Invoke-TssRestApi @invokeParams
                    } catch {
                        Write-Warning "Issue getting details on [$reportCategory]"
                        $err = $_.ErrorDetails.Message
                        Write-Error $err
                    }

                    if ($tssReportCatParams['Raw']) {
                        return $restResponse
                    }
                    if ($restResponse) {
                        . $TssReportCategoryObject $restResponse
                    }
                }
            }
            if ($tssReportCatParams['All']) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'reports/categories' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                Write-Verbose "$($invokeParams.Method) $uri"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue getting details on [$reportCategory]"
                    $err = $_.ErrorDetails.Message
                    Write-Error $err
                }

                if ($restResponse) {
                    . $TssReportCategoryObject $restResponse.model -All:$All
                }

            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}