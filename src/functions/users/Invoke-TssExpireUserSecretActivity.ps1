function Invoke-TssExpireUserSecretActivity {
    <#
    .SYNOPSIS
    Expire the secrets a user has accessed

    .DESCRIPTION
    Expires every secret the user accessed that matches the filter, so each one is due for a password change.
    The expiration runs as a bulk operation; the result carries its bulk operation ID.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    ID of the user whose accessed secrets are expired

    .PARAMETER StartDate
    Only secrets accessed on or after this date (required: without it the server fails with a SQL date overflow)

    .PARAMETER EndDate
    Only secrets accessed before this date

    .PARAMETER FolderId
    Only secrets in this folder

    .PARAMETER IncludeSubfolders
    With -FolderId, also secrets in its subfolders

    .PARAMETER ExcludeInactiveSecrets
    Skip inactive secrets

    .PARAMETER ExcludeRotatedSecrets
    Skip secrets whose passwords rotate automatically

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssExpireUserSecretActivity -TssSession $session -Id 12 -StartDate (Get-Date).AddDays(-30)

    Expires every secret user 12 accessed in the last 30 days

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssExpireUserSecretActivity -TssSession $session -Id 12 -StartDate (Get-Date).AddDays(-90) -FolderId 7 -IncludeSubfolders -ExcludeRotatedSecrets -WhatIf

    Shows the request that would expire the secrets user 12 accessed under folder 7 in the last 90 days, skipping secrets that rotate automatically

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Invoke-TssExpireUserSecretActivity

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Invoke-TssExpireUserSecretActivity.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Users.SecretActivityExpireResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [datetime]
        $StartDate,

        [datetime]
        $EndDate,

        [int]
        $FolderId,

        [switch]
        $IncludeSubfolders,

        [switch]
        $ExcludeInactiveSecrets,

        [switch]
        $ExcludeRotatedSecrets
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'users', $currentId, 'secret-activity', 'expire' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                $filter = @{ }
                switch ($tssParams.Keys) {
                    'StartDate' {
                        $filter.Add('startDate', $StartDate.ToString('o'))
                    }
                    'EndDate' {
                        $filter.Add('endDate', $EndDate.ToString('o'))
                    }
                    'FolderId' {
                        $filter.Add('folderId', $FolderId)
                    }
                    'IncludeSubfolders' {
                        $filter.Add('includeSubfolders', [boolean]$IncludeSubfolders)
                    }
                    'ExcludeInactiveSecrets' {
                        $filter.Add('excludeInactiveSecrets', [boolean]$ExcludeInactiveSecrets)
                    }
                    'ExcludeRotatedSecrets' {
                        $filter.Add('excludeRotatedSecrets', [boolean]$ExcludeRotatedSecrets)
                    }
                }
                $body = @{ data = @{ filter = $filter } }
                $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("User: $currentId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Invoke-TssExpireUserSecretActivity request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Users.SecretActivityExpireResult]@{
                            Success         = $restResponse.success
                            BulkOperationId = $restResponse.operationMessage.bulkOperationId
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
