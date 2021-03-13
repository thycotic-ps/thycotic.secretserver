function Remove-ReportCategory {
    <#
    .SYNOPSIS
    Delete a report category

    .DESCRIPTION
    Deletes the report category, associated reports are changed to inactive and moved to the Delete category

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssReportCategory -TssSession $session -Id 11

    A confirmation prompt will be shown.
    Removes report category 11

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssReportCategory -TssSession $session -Id 21 -Confirm:$false

    Confirmation prompt is bypassed
    Removes report category 21

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Remove-TssReportCategory

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('TssDelete')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Category ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $ReportCategoryId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($id in $ReportCategoryId) {
                $uri = $TssSession.ApiUrl, 'reports/categories', $id.ToString() -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'


                Write-Verbose "$($invokeParams.Method) $uri"
                if (-not $PSCmdlet.ShouldProcess("RemoteCategoryId: $id", "$($invokeParams.Method) $uri")) { return }
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue removing [$id]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssDelete]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}