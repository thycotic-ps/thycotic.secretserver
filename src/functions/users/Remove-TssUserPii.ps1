function Remove-TssUserPii {
    <#
    .SYNOPSIS
    Delete a user's personally identifiable info

    .DESCRIPTION
    Delete a user's personally identifiable info. This cannot be undone.

    Applies the same rules as the Remove PII button in the Secret Server UI. A user is skipped with a warning unless:
    - the user is disabled (run Disable-TssUser first)
    - the user has at least one user audit record
    - the user's PII has not already been removed

    The audit check reads up to TssSession.Take records, so a session with a low Take can miss an earlier removal.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Remove-TssUserPii -TssSession $session -Id 56

    Secret Server will go through and delete identified PII data for user 56

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Remove-TssUserPii

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Remove-TssUserPii.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Common.Delete')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # User ID
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("UserId")]
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
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($user in $Id) {
                $restResponse = $null

                $target = Get-TssUser -TssSession $TssSession -Id $user
                if (-not $target) {
                    Write-Warning "User [$user] not found, PII not removed"
                    continue
                }
                if ($target.Enabled) {
                    Write-Warning "User [$user] is active, run Disable-TssUser first. PII not removed"
                    continue
                }
                $audits = Get-TssUserAudit -TssSession $TssSession -UserId $user
                if (-not $audits) {
                    Write-Warning "User [$user] has no audit history, PII not removed"
                    continue
                }
                if ($audits.Action -contains 'REMOVE PERSONALLY IDENTIFIABLE INFORMATION') {
                    Write-Warning "User [$user] PII has already been removed"
                    continue
                }

                $uri = $TssSession.ApiUrl, 'users', 'delete-pii', $user -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'

                if ($PSCmdlet.ShouldProcess($user,"$($invokeParams.Method) $($invokeParams.Uri)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue deleting PII for user [$user]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Common.Delete]@{
                            Id         = $user
                            ObjectType = 'PII'
                        }
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}