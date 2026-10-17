function Test-TssCurrentUserPassword {
    <#
    .SYNOPSIS
    Test whether a password is the password of the current user

    .DESCRIPTION
    Verifies a password against the account of the user who owns the session.
    Returns True when the password matches and False when it does not.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Password
    Password to verify

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Test-TssCurrentUserPassword -TssSession $session -Password (Read-Host -AsSecureString)

    Prompts for a password and returns True when it is the password of the current user

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Test-TssCurrentUserPassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Test-TssCurrentUserPassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('System.Boolean')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory)]
        [securestring]
        $Password
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'users', 'verify-password' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Password' {
                    $body.Add('password', [System.Net.NetworkCredential]::new('', $Password).Password)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                if ([int]$apiResponse.StatusCode -eq 400 -and $apiResponse.Content -match 'Invalid password') {
                    $false
                    return
                }
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssCurrentUserPassword request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($null -ne $restResponse) {
                [System.Convert]::ToBoolean($restResponse)
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
