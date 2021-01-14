function Get-TssSecret {
    <#
    .SYNOPSIS
    Get a secret from Secret Server

    .DESCRIPTION
    Get a secret(s) from Secret Server

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssSecret -TssSession $session -Id 93

    Returns secret associated with the Secret ID, 93

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> Get-TssSecret -TssSession $session -Id 1723 -Comment "Accessing application Y"

    Returns secret associated with the Secret ID, 1723, providing required comment

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> $secret = Get-TssSecret -TssSession $session -Id 46
    PS C:\> $cred = $secret.GetCredential()

    Gets Secret ID 46 and then output a PSCredential to utilize in script workflow

    .EXAMPLE
    PS C:\> $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    PS C:\> $secret = Search-TssSecret -TssSesion $session -FieldSlug server -FieldText 'sql1' | Get-TssSecret
    PS C:\> $cred = $secret.GetCredential()
    PS C:\> $serverName = $secret.GetValue('server')

    Search for the secret with server value of sql1 and pull the secret details
    Call GetCredential() method to get the PSCredential object with the username and password
    Call GetValue() method passing the slug name to grab the ItemValue of the server field.

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(DefaultParameterSetName = 'secret')]
    [OutputType('TssSecret')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,
            ValueFromPipeline,
            Position = 0)]
        [TssSession]$TssSession,

        # Secret ID to retrieve
        [Parameter(Mandatory,
            ValueFromPipelineByPropertyName,
            ParameterSetName = 'secret')]
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
        $ForceCheckin,

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
        $TicketSystemId,

        # Output the raw response from the REST API endpoint
        [switch]
        $Raw
    )
    begin {
        $tssParams = . $GetParams $PSBoundParameters 'Get-TssSecret'
        $invokeParams = @{ }
    }

    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($tssParams.Contains('TssSession') -and $TssSession.IsValidSession()) {
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret.ToString() -join '/'

                $body = @{}
                if ($PSCmdlet.ParameterSetName -eq 'restricted') {
                    switch ($tssParams) {
                        'Comment' {
                            $body.Add('comment',$Comment)
                        }
                        'DoublelockPassword' {
                            $passwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($DoublelockPassword))
                            $body.Add('doubleLockPassword',$passwd)
                        }
                        'ForceCheckIn' {
                            $body.Add('forceCheckIn',$ForceCheckIn)
                        }
                        'IncludeInactive' {
                            $body.Add('includeInactive',$IncludeInactive)
                        }
                        'TicketNumber' {
                            $body.Add('ticketNumber',$TicketNumber)
                        }
                        'TicketSystemId' {
                            $body.Add('ticketSystemId',$TicketSystemId)
                        }
                    }
                    $uri = $uri, 'restricted' -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'POST'
                    $invokeParams.Body = $body
                } else {
                    $uri = $uri
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'
                }

                $invokeParams.PersonalAccessToken = $TssSession.AccessToken

                Write-Verbose "$($invokeParams.Method) $uri with $body"
                try {
                    $restResponse = Invoke-TssRestApi @invokeParams
                } catch {
                    Write-Warning "Issue getting secret [$secret]"
                    $err = $_.ErrorDetails.Message
                    Write-Error $err
                }

                if ($tssParams['Raw']) {
                    return $restResponse
                }
                if ($restResponse) {
                    . $TssSecretObject $restResponse
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}