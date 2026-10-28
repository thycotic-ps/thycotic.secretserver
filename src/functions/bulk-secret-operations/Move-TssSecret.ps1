function Move-TssSecret {
    <#
    .SYNOPSIS
    Move secrets to a folder

    .DESCRIPTION
    Move one or more secrets to a folder in one bulk operation.
    Moved secrets inherit permissions from the target folder unless -RetainPermissionInheritance is set.
    The operation runs in the background: pipe the output (BulkOperationId is the task identifier) to Get-TssBulkOperationProgress to follow it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER FolderId
    ID of the folder to move the secrets to

    .PARAMETER RetainPermissionInheritance
    Keep each secret's current permission inheritance setting instead of inheriting from the target folder

    .PARAMETER Id
    IDs of the secrets to move

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Move-TssSecret -TssSession $session -Id 42 -FolderId 7

    Move secret 42 to folder 7

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Move-TssSecret -TssSession $session -Id 42, 43 -FolderId 7 -RetainPermissionInheritance | Get-TssBulkOperationProgress -TssSession $session

    Move secrets 42 and 43 to folder 7 keeping their permission inheritance setting, then check the progress

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/bulk-secret-operations/Move-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/bulk-secret-operations/Move-TssSecret.ps1

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
        [int]
        $FolderId,

        [switch]
        $RetainPermissionInheritance,

        [Parameter(Mandatory)]
        [Alias('SecretId')]
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
            Compare-TssVersion $TssSession '11.2.000004' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'bulk-secret-operations', 'move-to-folder' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'FolderId' {
                    $body.data.Add('folderId', $FolderId)
                }
                'RetainPermissionInheritance' {
                    $body.data.Add('retainPermissionInheritance', [boolean]$RetainPermissionInheritance)
                }
                'Id' {
                    $body.data.Add('secretIds', $Id)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Secret", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Move-TssSecret request'
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
