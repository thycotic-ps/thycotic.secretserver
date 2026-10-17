function Invoke-TssSecretChangePassword {
    <#
    .SYNOPSIS
    Queue a remote password change on a secret

    .DESCRIPTION
    Queue a remote password change (RPC) on a secret through the public REST route.
    Without -NewPassword (or the SSH key parameters) Secret Server generates the next value from the template's password requirements.
    The change runs on the next Remote Password Changing cycle; follow it with Get-TssSecretPasswordStatus.
    Remote Password Changing must be enabled and the secret's template must have a password changer; the server rejects the request otherwise.
    Start-TssSecretChangePassword uses the internal change-password-now route instead; this command also takes a comment, a ticket number, a double lock password and SSH key options.
    The request body is never written to Verbose or WhatIf output.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER Id
    Secret ID

    .PARAMETER NewPassword
    Next password; omit to let Secret Server generate one

    .PARAMETER Comment
    Comment for the secret audit, required when the secret requires a comment

    .PARAMETER TicketNumber
    Ticket number, required when the secret requires a ticket number

    .PARAMETER TicketSystemId
    Ticket system ID used to validate -TicketNumber

    .PARAMETER DoubleLockPassword
    Double lock password, required when the secret is double locked

    .PARAMETER ForceCheckIn
    Check the secret in first when another user has it checked out

    .PARAMETER IncludeInactive
    Allow the change on an inactive secret

    .PARAMETER NoAutoCheckout
    Do not check the secret out automatically

    .PARAMETER IsForceCheckoutRequestApproval
    Request approval for a forced check-out

    .PARAMETER PreventFurtherRetriesAfterMaxAttempts
    Stop retrying the change once the maximum number of attempts is reached

    .PARAMETER GenerateSshKeys
    SSH key secrets: generate the next private key

    .PARAMETER GeneratePassphrase
    SSH key secrets: generate the next passphrase

    .PARAMETER PrivateKey
    SSH key secrets: next private key text

    .PARAMETER Passphrase
    SSH key secrets: next passphrase

    .PARAMETER AutoCheckIn
    Check the secret in automatically after the request

    .PARAMETER AutoCheckout
    Check the secret out automatically for the request

    .PARAMETER AutoComment
    Comment to use for the automatic check-out

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssSecretChangePassword -TssSession $session -Id 46 -Comment 'Quarterly rotation'

    Queue a password change on secret 46 with a server-generated password

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $next = Read-Host -AsSecureString -Prompt 'Next password'
    Invoke-TssSecretChangePassword -TssSession $session -Id 46 -NewPassword $next
    Get-TssSecretPasswordStatus -TssSession $session -Id 46

    Queue a change to a caller-supplied password, then read the change status

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Invoke-TssSecretChangePassword -TssSession $session -Id 52 -GenerateSshKeys -GeneratePassphrase

    Queue a rotation of the private key and passphrase on SSH key secret 52

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Invoke-TssSecretChangePassword

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Invoke-TssSecretChangePassword.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.Summary')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        [securestring]
        $NewPassword,

        [string]
        $Comment,

        [string]
        $TicketNumber,

        [int]
        $TicketSystemId,

        [securestring]
        $DoubleLockPassword,

        [switch]
        $ForceCheckIn,

        [switch]
        $IncludeInactive,

        [switch]
        $NoAutoCheckout,

        [switch]
        $IsForceCheckoutRequestApproval,

        [switch]
        $PreventFurtherRetriesAfterMaxAttempts,

        [switch]
        $GenerateSshKeys,

        [switch]
        $GeneratePassphrase,

        [string]
        $PrivateKey,

        [securestring]
        $Passphrase,

        [switch]
        $AutoCheckIn,

        [switch]
        $AutoCheckout,

        [string]
        $AutoComment
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $queryParams = @()
            switch ($tssParams.Keys) {
                'AutoCheckIn' {
                    $queryParams += "autoCheckIn=$([boolean]$AutoCheckIn)"
                }
                'AutoCheckout' {
                    $queryParams += "autoCheckout=$([boolean]$AutoCheckout)"
                }
                'AutoComment' {
                    $queryParams += "autoComment=$([uri]::EscapeDataString($AutoComment))"
                }
            }
            $body = @{ }
            switch ($tssParams.Keys) {
                'NewPassword' {
                    $body.Add('newPassword', [System.Net.NetworkCredential]::new('', $NewPassword).Password)
                }
                'Comment' {
                    $body.Add('comment', $Comment)
                }
                'TicketNumber' {
                    $body.Add('ticketNumber', $TicketNumber)
                }
                'TicketSystemId' {
                    $body.Add('ticketSystemId', $TicketSystemId)
                }
                'DoubleLockPassword' {
                    $body.Add('doubleLockPassword', [System.Net.NetworkCredential]::new('', $DoubleLockPassword).Password)
                }
                'ForceCheckIn' {
                    $body.Add('forceCheckIn', [boolean]$ForceCheckIn)
                }
                'IncludeInactive' {
                    $body.Add('includeInactive', [boolean]$IncludeInactive)
                }
                'NoAutoCheckout' {
                    $body.Add('noAutoCheckout', [boolean]$NoAutoCheckout)
                }
                'IsForceCheckoutRequestApproval' {
                    $body.Add('isForceCheckoutRequestApproval', [boolean]$IsForceCheckoutRequestApproval)
                }
                'PreventFurtherRetriesAfterMaxAttempts' {
                    $body.Add('preventFurtherRetriesAfterMaxAttempts', [boolean]$PreventFurtherRetriesAfterMaxAttempts)
                }
            }
            if ($GenerateSshKeys -or $GeneratePassphrase -or $tssParams.ContainsKey('PrivateKey') -or $tssParams.ContainsKey('Passphrase')) {
                $sshKeyArgs = @{
                    generateSshKeys    = [boolean]$GenerateSshKeys
                    generatePassphrase = [boolean]$GeneratePassphrase
                }
                if ($tssParams.ContainsKey('PrivateKey')) {
                    $sshKeyArgs.Add('privateKey', $PrivateKey)
                }
                if ($tssParams.ContainsKey('Passphrase')) {
                    $sshKeyArgs.Add('passphrase', [System.Net.NetworkCredential]::new('', $Passphrase).Password)
                }
                $body.Add('sshKeyArgs', $sshKeyArgs)
            }
            foreach ($currentId in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $currentId, 'change-password' -join '/'
                if ($queryParams) {
                    $uri = $uri, ($queryParams -join '&') -join '?'
                }
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'POST'
                $invokeParams.Body = $body | ConvertTo-Json -Depth 100
                if ($PSCmdlet.ShouldProcess("Secret ID: $currentId", "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue queueing a password change on Secret [$currentId]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                    if ($restResponse) {
                        [Thycotic.PowerShell.Secrets.Summary](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Secrets.Summary]))
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
