function Disable-TssBulkPasswordChanger {
    <#
    .SYNOPSIS
    Disable password changers in bulk

    .DESCRIPTION
    Disable one or more Remote Password Changing password changers in one bulk operation.
    The operation runs in the background: pipe the output (BulkOperationId is the task identifier) to Get-TssBulkOperationProgress to follow it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    IDs of the password changers to disable

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Disable-TssBulkPasswordChanger -TssSession $session -Id 3, 4, 5

    Disable password changers 3, 4 and 5

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-password-changer-operations/Disable-TssBulkPasswordChanger

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-password-changer-operations/Disable-TssBulkPasswordChanger.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.BulkOperations.Response')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [Alias('PasswordChangerId')]
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
            Compare-TssVersion $TssSession '11.9.000006' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'bulk-password-changer-operations', 'disable' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'Id' {
                    $body.data.Add('passwordChangerIds', $Id)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Bulk password changer", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Disable-TssBulkPasswordChanger request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.BulkOperations.Response](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.BulkOperations.Response]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
