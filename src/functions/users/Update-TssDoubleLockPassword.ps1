function Update-TssDoubleLockPassword {
    <#
    .SYNOPSIS
    Unlock DoubleLock for the current user with their DoubleLock password

    .DESCRIPTION
    Verifies the existing DoubleLock password of the user who owns the session and unlocks DoubleLock for that user, so DoubleLock secrets can be read.
    The server keeps the unlock per user, not per session: every session of the same user is unlocked, for up to an hour.
    It does not create or change a DoubleLock password.
    A user without a DoubleLock password gets the error "User has not created a QuantumLock password." (QuantumLock is the former name of DoubleLock).
    A wrong password fails, and repeated wrong passwords block further attempts for a few minutes.
    Returns True on success.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Password
    Current DoubleLock password of the user who owns the session

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Update-TssDoubleLockPassword -TssSession $session -Password (Read-Host -AsSecureString)

    Prompts for the DoubleLock password of the current user and unlocks DoubleLock for that user

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/users/Update-TssDoubleLockPassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/users/Update-TssDoubleLockPassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
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
            $uri = $TssSession.ApiUrl, 'users', 'doublelock-password' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PUT'
            $body = @{ }
            switch ($tssParams.Keys) {
                'Password' {
                    $body.Add('password', [System.Net.NetworkCredential]::new('', $Password).Password)
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("DoubleLock password", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Update-TssDoubleLockPassword request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($null -ne $restResponse) {
                    [System.Convert]::ToBoolean($restResponse)
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
