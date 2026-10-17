function Search-TssBulkOperation {
    <#
    .SYNOPSIS
    Search bulk operations

    .DESCRIPTION
    Search bulk operations by name, category, status, or the user who started them.
    With no filter, lists every bulk operation.
    Users without the Administer Bulk Operations role permission see only the operations they started: the server replaces -StartUserId with their own user ID.
    The Administrator role does not include that permission by default.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER BulkOperationName
    Filter by bulk operation name

    .PARAMETER Category
    Filter by the type of item the operation acts on

    .PARAMETER StartUserId
    Filter by the ID of the user who started the operation.
    Applied only when the caller holds the Administer Bulk Operations role permission; otherwise the server returns the caller's own operations.

    .PARAMETER Status
    Filter by operation status

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssBulkOperation -TssSession $session

    List every bulk operation

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Search-TssBulkOperation -TssSession $session -Category User -Status Error

    List the user bulk operations that ended in error

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Search-TssBulkOperation

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Search-TssBulkOperation.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.BulkOperations.BulkOperation[]')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [string]
        $BulkOperationName,

        [ValidateSet('Secret', 'SecretDependency', 'User')]
        [string]
        $Category,

        [int]
        $StartUserId,

        [ValidateSet('Running', 'Stopped', 'Completed', 'Error')]
        [string]
        $Status
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.10.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'bulk-operations' -join '/'
            $queryParams = @()
            $queryParams += "take=$($TssSession.Take)"
            switch ($tssParams.Keys) {
                'BulkOperationName' {
                    $queryParams += "filter.bulkOperationName=$([uri]::EscapeDataString($BulkOperationName))"
                }
                'Category' {
                    $queryParams += "filter.category=$([uri]::EscapeDataString($Category))"
                }
                'StartUserId' {
                    $queryParams += "filter.startUserId=$($StartUserId)"
                }
                'Status' {
                    $queryParams += "filter.status=$([uri]::EscapeDataString($Status))"
                }
            }
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
                Write-Warning 'Issue with Search-TssBulkOperation request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse.records) {
                [Thycotic.PowerShell.BulkOperations.BulkOperation[]](. $FilterTssResponse $restResponse.records ([Thycotic.PowerShell.BulkOperations.BulkOperation]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
