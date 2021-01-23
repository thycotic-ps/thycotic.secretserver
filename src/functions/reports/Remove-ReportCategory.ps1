function Remove-ReportCategory {
    <#
    .SYNOPSIS
    Delete a report category

    .DESCRIPTION
    Deletes the report category, associated reports are changed to inactive and moved to the Delete category

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Remove-TssReportCategory -TssSession $session -Id 11

    A confirmation prompt will be shown.
    Removes report category 11

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Remove-TssReportCategory -TssSession $session -Id 21 -Confirm:$false

    Confirmation prompt is bypassed
    Removes report category 21

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Boolean')]
    param (
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Category ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias('Id')]
        [int[]]
        $ReportCategoryId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($id in $ReportCategoryId) {
                $uri = $TssSession.ApiUrl, 'reports/categories', $id.ToString() -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'DELETE'

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken
                Write-Verbose "$($invokeParams.Method) $uri"
                if (-not $PSCmdlet.ShouldProcess($id, "$($invokeParams.Method) $uri")) { return }
                try {
                    Invoke-TssRestApi @invokeParams
                    $true
                } catch {
                    Write-Warning "Issue removing [$id]"
                    $err = $_.ErrorDetails.Message
                    Write-Error $err
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}