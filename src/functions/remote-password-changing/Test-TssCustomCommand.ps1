function Test-TssCustomCommand {
    <#
    .SYNOPSIS
    Test the custom commands of a password type against a target

    .DESCRIPTION
    Runs the custom commands of one command type of a password type against a target system, through a site, and returns the console output, the error message and whether the run succeeded.
    The commands really run on the target with the account in -Credential.
    Target details go in -Field, keyed by the token name the commands use without the $ (for example Machine).
    The request body is not written to Verbose output because it carries the account password, passphrase and key.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER PasswordTypeId
    ID of the password type whose commands are tested

    .PARAMETER CommandTypeCode
    Command type code of the commands to run: 1 password change, 2 verify password (heartbeat), 3 password change with other credentials

    .PARAMETER SiteId
    ID of the site (distributed engine site) that runs the commands

    .PARAMETER Credential
    Account the commands run as

    .PARAMETER Passphrase
    Passphrase of the private key in -KeyInput. An empty passphrase is sent when omitted (the server requires the field for SSH password types)

    .PARAMETER KeyInput
    Private key text for key based logins, for example the output of Get-Content -Raw on a key file

    .PARAMETER PasswordTypeWebScriptId
    Web script ID, for web based password types

    .PARAMETER Field
    Token values as a hashtable of token name (without the $) and value, for example @{ Machine = 'unix01.example.com' }

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $cred = Get-Credential
    Test-TssCustomCommand -TssSession $session -PasswordTypeId 9 -CommandTypeCode 1 -SiteId 1 -Credential $cred -Field @{ Machine = 'unix01.example.com' }

    Run the type 1 commands of password type 9 against unix01 through site 1 and show the result

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/remote-password-changing/Test-TssCustomCommand

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/remote-password-changing/Test-TssCustomCommand.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Rpc.CustomCommandTestResult')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [int]
        $PasswordTypeId,

        [Parameter(Mandatory)]
        [ValidateSet(1, 2, 3)]
        [int]
        $CommandTypeCode,

        [Parameter(Mandatory)]
        [int]
        $SiteId,

        [Parameter(Mandatory)]
        [pscredential]
        $Credential,

        [securestring]
        $Passphrase,

        [string]
        $KeyInput,

        [int]
        $PasswordTypeWebScriptId,

        [hashtable]
        $Field
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'remote-password-changing', 'custom-command', 'test' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'POST'
            $body = @{
                passwordTypeId  = $PasswordTypeId
                commandTypeCode = $CommandTypeCode
                siteId          = $SiteId
                userName        = $Credential.UserName
            }
            $body.Add('password', $Credential.GetNetworkCredential().Password)
            $body.Add('passphrase', [System.Net.NetworkCredential]::new('', $Passphrase).Password)
            switch ($tssParams.Keys) {
                'KeyInput' {
                    $body.Add('keyInput', $KeyInput)
                }
                'PasswordTypeWebScriptId' {
                    $body.Add('passwordTypeWebScriptId', $PasswordTypeWebScriptId)
                }
                'Field' {
                    $body.Add('fields', @($Field.GetEnumerator() | ForEach-Object { @{ key = [string]$_.Key; value = [string]$_.Value } }))
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            $restResponse = $null
            Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning 'Issue with Test-TssCustomCommand request'
                $err = $_
                . $ErrorHandling $err
            }
            if ($restResponse) {
                [Thycotic.PowerShell.Rpc.CustomCommandTestResult](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Rpc.CustomCommandTestResult]))
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
