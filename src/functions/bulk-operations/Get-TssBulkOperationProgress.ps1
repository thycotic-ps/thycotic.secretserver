function Get-TssBulkOperationProgress {
    <#
    .SYNOPSIS
    Get the progress of a bulk operation

    .DESCRIPTION
    Get the progress of a bulk operation by its task identifier (a GUID): percentage complete, status message, completion flag, and per-item errors.
    Move-TssSecret, Invoke-TssBulkSecretAction, Invoke-TssBulkUserAction, Set-TssUserTwoFactor, Enable-TssBulkPasswordChanger and Disable-TssBulkPasswordChanger return the task identifier as BulkOperationId, so their output pipes here.
    An unknown task identifier returns an incomplete progress object (0 percent), not an error.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Task identifier (GUID) of the bulk operation: BulkOperationId from the bulk cmdlets, or TaskIdentifier from Get-TssBulkOperation

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssBulkOperationProgress -TssSession $session -Id 7792fb1d-9e2b-4378-b3d2-07894e38999b

    Get the progress of the bulk operation with that task identifier

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Move-TssSecret -TssSession $session -Id 42, 43 -FolderId 7 | Get-TssBulkOperationProgress -TssSession $session

    Move secrets 42 and 43 to folder 7, then check the progress of the move

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-operations/Get-TssBulkOperationProgress

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-operations/Get-TssBulkOperationProgress.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.BulkOperations.Progress')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('TaskIdentifier', 'TaskId', 'BulkOperationId')]
        [string[]]
        $Id
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '11.2.000004' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'bulk-operations', $currentId, 'progress' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'GET'
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Get-TssBulkOperationProgress request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.BulkOperations.Progress](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.BulkOperations.Progress]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
