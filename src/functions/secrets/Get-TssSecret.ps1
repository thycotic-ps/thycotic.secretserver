function Get-TssSecret {
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

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecret -TssSession $session -Path '\ABC Company\Vendors\Temp Secret - 32.178.249.171'

    Get Secret via absolute path.

    .EXAMPLE
    $session = nts https://alpha $ssCred
    (gts $session 330).GetCredential($null,'username','password')

    Get PSCredential object for Secret ID 330, using alias for the function names

    .EXAMPLE
    $session = nts https://alpha $ssCred
    $secret = Get-TssSecret $session 330
    $secret.GetFileFields().Foreach({Get-TssSecretField -Id $secret.Id -Slug $_.SlugName})

    Get the Secert 330, pulling the fields on that Secret that are files and output contents of each file to the console.

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecret

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecret.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(DefaultParameterSetName = 'all')]
    [OutputType('Thycotic.PowerShell.Secrets.Secret')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID to retrieve
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, Position = 0)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # Secret ID to retrieve
        [Parameter(ParameterSetName = 'path')]
        [Parameter(ParameterSetName = 'all')]
        [string]
        $Path,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $Comment,

        # Double lock password, provie as a secure string
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'restricted')]
        [securestring]
        $DoublelockPassword,

        # Check in the secret if it is checked out
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'restricted')]
        [switch]
        $ForceCheckIn,

        # Include secrets that are inactive/disabled
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'restricted')]
        [switch]
        $IncludeInactive,

        # Associated ticket number (required for ticket integrations)
        [Parameter(ParameterSetName = 'all')]
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $TicketNumber,

        # Associated ticket system ID (required for ticket integrations)
        [Parameter(ParameterSetName = 'all')]
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

            if ($tssParams.ContainsKey('Path')) {
                $secretName = Split-Path $Path -Leaf
                $pathLeaf = Split-Path (Split-Path $Path -Parent) -Leaf
                $folderFound = . $SearchFolders $TssSession $pathLeaf | Where-Object FolderPath -EQ $Path
                $folderId = $folderFound.Id
                $searchSecret = Search-TssSecret $TssSession -FolderId $folderId -SearchText $secretName
                $Id = $searchSecret.Where({ $_.Name -eq $secretName }).Id

                if (-not $Id) {
                    Write-Verbose "No secret found at path [$Path]"
                    return
                }
            }

            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl, 'secrets', $secret -join '/'

                $getBody = @{}
                if ($restrictedParams.Count -gt 0) {
                    switch ($tssParams.Keys) {
                        'IncludeInactive' { $getBody.Add('includeInactive', [boolean]$IncludeInactive) }
                        'Comment' { $getBody.Add('comment', $Comment) }
                        'ForceCheckIn' { $getBody.Add('forceCheckIn', [boolean]$ForceCheckIn) }
                        'TicketNumber' { $getBody.Add('ticketNumber', $TicketNumber) }
                        'TicketSystemId' { $getBody.Add('ticketSystemId', $TicketSystemId) }
                        'DoublelockPassword' {
                            $passwd = [Runtime.InteropServices.Marshal]::PtrToStringAuto([Runtime.InteropServices.Marshal]::SecureStringToBSTR($DoublelockPassword))
                            $getBody.Add('doubleLockPassword', $passwd)
                        }
                    }

                    $uri = $uri, 'restricted' -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'POST'
                    $invokeParams.Body = $getBody | ConvertTo-Json
                } else {
                    $uri = $uri
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'
                }

                Write-Verbose "$($invokeParams.Method) $uri with:`t$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue getting secret [$secret]"
                    $err = $_
                    . $ErrorHandling $err
                }

                if ($restResponse) {
                    if ($restResponse.Code) {
                        $responseCodeMsg = $restResponse | ConvertTo-Json
                        Write-Error "Issue accessing secret:`n $responseCodeMsg"
                    } else {
                        [Thycotic.PowerShell.Secrets.Secret]$restResponse
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}