function Get-TssBulkOperation {
    <#
    .SYNOPSIS
    Get a bulk operation

    .DESCRIPTION
    Get a bulk operation by its numeric ID: name, category, status, item counts, the users who started and stopped it, start and end dates, and its task identifier.
    Get-TssBulkOperationProgress and Stop-TssBulkOperation take the task identifier (TaskIdentifier), not this ID.
    Users without the Administer Bulk Operations permission see only the operations they started.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Bulk operation ID

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssBulkOperation -TssSession $session -Id 12

    Get bulk operation 12

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssBulkOperation -TssSession $session -Status Running | Get-TssBulkOperation -TssSession $session

    Get the details of every running bulk operation

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Get-TssBulkOperation

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Get-TssBulkOperation.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.BulkOperations.BulkOperation')]
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
                $uri = $TssSession.ApiUrl, 'bulk-operations', $currentId -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssBulkOperation request'
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
