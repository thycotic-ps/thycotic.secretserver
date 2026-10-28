function Reset-TssUserTwoFactor {
    <#
    .SYNOPSIS
    Reset the two-factor authentication of a user

    .DESCRIPTION
    Resets the TOTP or FIDO2 two-factor enrollment of a user. The user sets it up again at the next login.
    Fails with access denied when the user is not enrolled in that method.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    User ID

    .PARAMETER TwoFactorType
    Two-factor method to reset: Oath (TOTP) or Fido (FIDO2)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Reset-TssUserTwoFactor -TssSession $session -Id 42 -TwoFactorType Oath

    Resets the TOTP enrollment of user 42

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Reset-TssUserTwoFactor

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Reset-TssUserTwoFactor.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Users.ActionResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('UserId')]
        [int[]]
        $Id,

        [Parameter(Mandatory)]
        [ValidateSet('Oath', 'Fido')]
        [string]
        $TwoFactorType
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
                $uri = $TssSession.ApiUrl, 'users', $currentId, 'reset-two-factor' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                $body = @{ data = @{ } }
                switch ($tssParams.Keys) {
                    'TwoFactorType' {
                        $body.data.Add('twoFactorType', $TwoFactorType)
                    }
                }
                $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("User: $currentId", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue with Reset-TssUserTwoFactor request'
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Users.ActionResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Users.ActionResult]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
