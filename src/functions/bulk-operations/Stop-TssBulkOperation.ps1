function Stop-TssBulkOperation {
    <#
    .SYNOPSIS
    Stop a running bulk operation

    .DESCRIPTION
    Stop a running bulk operation by its task identifier and return the operation.
    A stopped operation cannot be resumed; items already processed stay changed.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Task identifier (GUID) of the bulk operation: TaskIdentifier from Get-TssBulkOperation, or BulkOperationId from the bulk cmdlets

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Stop-TssBulkOperation -TssSession $session -Id 7792fb1d-9e2b-4378-b3d2-07894e38999b

    Stop the bulk operation with that task identifier

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssBulkOperation -TssSession $session -Status Running | Stop-TssBulkOperation -TssSession $session

    Stop every running bulk operation

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Stop-TssBulkOperation

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Stop-TssBulkOperation.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.BulkOperations.BulkOperation')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TaskIdentifier', 'TaskId', 'BulkOperationId')]
        [string]
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
            $uri = $TssSession.ApiUrl, 'bulk-operations', $Id, 'stop' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            if ($PSCmdlet.ShouldProcess("Bulk operation: $Id", "$($invokeParams.Method) $uri")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Stop-TssBulkOperation request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.BulkOperations.BulkOperation](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.BulkOperations.BulkOperation]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
