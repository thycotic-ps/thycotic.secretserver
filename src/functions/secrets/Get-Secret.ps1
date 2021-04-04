function Get-Secret {
    <#
    .SYNOPSIS
    Get a secret from Secret Server

    .DESCRIPTION
    Get a secret(s) from Secret Server

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecret -TssSession $session -Id 93

    Returns secret associated with the Secret ID, 93

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecret -TssSession $session -Id 1723 -Comment "Accessing application Y"

    Returns secret associated with the Secret ID, 1723, providing required comment

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $secret = Get-TssSecret -TssSession $session -Id 46
    $cred = $secret.GetCredential('domain','username','password')

    Gets Secret ID 46 (Active Directory template).
    Call GetCredential providing slug names for desired fields to get a PSCredential object

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $secret = Search-TssSecret -TssSession $session -FieldSlug server -FieldText 'sql1' | Get-TssSecret
    $cred = $secret.GetCredential($null,'username','password')
    $serverName = $secret.GetValue('server')

    Search for the secret with server value of sql1 and pull the secret details.
    Call GetCredential() method, only needing the username and password values for the PSCredential object.
    Call GetValue() method to get the 'server' value.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Get-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-Secret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(DefaultParameterSetName = 'secret')]
    [OutputType('TssSecret')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Secret ID to retrieve
        [Parameter(Mandatory,ValueFromPipelineByPropertyName,ParameterSetName = 'secret')]
        [Parameter(ParameterSetName = 'restricted')]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $Comment,

        # Double lock password, provie as a secure string
        [Parameter(ParameterSetName = 'restricted')]
        [securestring]
        $DoublelockPassword,

        # Check in the secret if it is checked out
        [Parameter(ParameterSetName = 'restricted')]
        [switch]
        $ForceCheckIn,

        # Include secrets that are inactive/disabled
        [Parameter(ParameterSetName = 'restricted')]
        [switch]
        $IncludeInactive,

        # Associated ticket number (required for ticket integrations)
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $TicketNumber,

        # Associated ticket system ID (required for ticket integrations)
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketSystemId
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession

        $restrictedParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'restricted'
        $restrictedParams = @()
        foreach ($r in $restrictedParamSet) {
            if ($tssParams.ContainsKey($r)) {
                $restrictedParams += $r
            }
        }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret -join '/'

                $getBody = @{}
                if ($restrictedParams.Count -gt 0) {
                    switch ($tssParams.Keys) {
                        'Comment' { $getBody.Add('comment', $Comment) }
                        'ForceCheckIn' { $getBody.Add('forceCheckIn', [boolean]$ForceCheckIn) }
                        'TicketNumber' { $getBody.Add('ticketNumber', $TicketNumber) }
                        'TicketSystemId' { $getBody.Add('ticketSystemId', $TicketSystemId) }
                        'DoublelockPassword' {
                            $passwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($DoublelockPassword))
                            $getBody.Add('doubleLockPassword',$passwd)
                        }
                    }

                    $uri = $uri, 'restricted' -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'POST'
                    $invokeParams.Body = $getBody | ConvertTo-Json
                }else {
                    $uri = $uri
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'
                }

                Write-Verbose "$($invokeParams.Method) $uri with:`t$($invokeParams.Body)`n"
                try {
                    $restResponse = . $InvokeApi @invokeParams
                } catch {
                    Write-Warning "Issue getting secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    [TssSecret]$restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}