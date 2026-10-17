function Get-TssBulkOperationAudit {
    <#
    .SYNOPSIS
    Get the audit records of a bulk operation

    .DESCRIPTION
    Get the per-item audit records of a bulk operation: the action, the affected secret or user, the date, and notes.
    Users without the Administer Bulk Operations permission see only the operations they started.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Bulk operation ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssBulkOperationAudit -TssSession $session -Id 12

    Get the audit records of bulk operation 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssBulkOperation -TssSession $session -Category Secret | Get-TssBulkOperationAudit -TssSession $session

    Get the audit records of every secret bulk operation

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Get-TssBulkOperationAudit

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Get-TssBulkOperationAudit.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.BulkOperations.Audit[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('BulkOperationId')]
        [int[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.10.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'bulk-operations', $currentId, 'audits' -join '/'
                $queryParams = @()
                $queryParams += "take=$($TssSession.Take)"
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssBulkOperationAudit request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse.records) {
                    [Thycotic.PowerShell.BulkOperations.Audit[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.BulkOperations.Audit]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
