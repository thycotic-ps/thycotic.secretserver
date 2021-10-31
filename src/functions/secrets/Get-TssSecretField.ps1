function Get-TssSecretField {
    <#
    .SYNOPSIS
    Get data of a field

    .DESCRIPTION
    Get data from a given secret field

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretField -TssSession $session -Id 14 -Slug username

    Get the username value of secret ID 14, output is in Byte[] format

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretField -TssSession $session -Id 432 -Slug json-private-key -OutFile C:\temp\private-key.json

    Get the private key from Secret 432, writing to the file private-key.json

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(DefaultParameterSetName = 'field')]
    [OutputType('System.String')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID to retrieve
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'field')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'restricted')]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # Secret ID to retrieve
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'field')]
        [Parameter(Mandatory, ParameterSetName = 'restricted')]
        [Alias('FieldName')]
        [string]
        $Slug,

        # Don't check out the secret automatically (added in 11.0+)
        [Parameter(ParameterSetName = 'field')]
        [Parameter(ParameterSetName = 'restricted')]
        [switch]
        $NoAutoCheckout,

        # Write contents to a file (for file attachments and SSH public/private keys)
        [Parameter(ParameterSetName = 'field')]
        [Parameter(ParameterSetName = 'restricted')]
        [System.IO.FileInfo]
        $OutFile,

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
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $uri = $TssSession.ApiUrl, 'secrets', $secret -join '/'

                $body = @{}
                if ($PSCmdlet.ParameterSetName -eq 'restricted') {
                    switch ($tssParams.Keys) {
                        'Comment' {
                            $body.Add('comment', $Comment)
                        }
                        'NoAutoCheckout' {
                            $body.Add('noAutoCheckout',[boolean]$NoAutoCheckout)
                        }
                        'DoublelockPassword' {
                            $passwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($DoublelockPassword))
                            $body.Add('doubleLockPassword', $passwd)
                        }
                        'ForceCheckIn' {
                            $body.Add('forceCheckIn', $ForceCheckIn)
                        }
                        'IncludeInactive' {
                            $body.Add('includeInactive', [boolean]$IncludeInactive)
                        }
                        'TicketNumber' {
                            $body.Add('ticketNumber', $TicketNumber)
                        }
                        'TicketSystemId' {
                            $body.Add('ticketSystemId', $TicketSystemId)
                        }
                    }
                    $uri = $uri, 'restricted/fields', $Slug -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'POST'
                    $invokeParams.Body = $body | ConvertTo-Json
                } else {
                    $uri = $uri, 'fields', $Slug -join '/'
                    if ($tssParams.ContainsKey('NoAutoCheckout')) {
                        $uri = $uri, "noAutoCheckout=$([boolean]$NoAutoCheckout)" -join '?'
                    }
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'
                }

                if ($tssParams['OutFile']) {
                    if (Test-Path -Path $OutFile -PathType Container) {
                        Write-Error "OutFile [$OutFile] provided is a directory, please provide full file path"
                        return
                    } elseif (-not (Test-Path -Path (Split-Path $OutFile -Parent))) {
                        Write-Error "OutFile [$OutFile] parent folder does exists or is not accessible"
                        return
                    } else {
                        $invokeParams.OutFile = $OutFile
                    }
                }
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri $(if ($body) {"with:`n$($invokeParams.Body)"})"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    if (-not $tssParams.ContainsKey('OutFile')) {
                        . $ProcessResponse $apiResponse
                    }
                } catch {
                    Write-Warning "Issue getting field [$Slug] on secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}