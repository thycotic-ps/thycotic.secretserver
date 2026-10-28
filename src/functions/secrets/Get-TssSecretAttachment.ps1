function Get-TssSecretAttachment {
    <#
    .SYNOPSIS
    Get a Secret attachment

    .DESCRIPTION
    Get a Secret attachment with the filename in order to write it out to disk. Combining the use of two public functions to write the attachment out to the given filename in the Secret.
    The filename of an attachment is in Get-TssSecret output (items)
    The content of the file is in Get-TssSecretField.
    With -OutFile the field is downloaded straight to that file path in one request (GET secrets/{id}/fields/{slug}).

    .PARAMETER OutFile
    Full path of the file to write the field content to

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretAttachment -TssSession $session -Id 35 -Slug attached-file -Path 'c:\thycotic'

    Get the Secert ID 35's field Attached File (using slug name attached-file), writing the file to c:\thycotic directory using the filename stored on that Secret

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssSecretAttachment -TssSession $session -Id 35 -Slug private-key -OutFile ./id_rsa

    Downloads the private-key field of secret 35 to the file id_rsa in the current folder

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Get-TssSecretAttachment

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Get-TssSecretAttachment.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Secret ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'id')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'path')]
        [Parameter(Mandatory, ValueFromPipelineByPropertyName, ParameterSetName = 'outfile')]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # Field name
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('FieldName')]
        [string]
        $Slug,

        # Write contents to a file (for file attachments and SSH public/private keys)
        [Parameter(Mandatory, ParameterSetName = 'path')]
        [ValidateScript( { Test-Path $_ -PathType Container })]
        [string]
        $Path,

        # Don't check out the secret automatically (added in 11.0+)
        [Parameter(ParameterSetName = 'id')]
        [Parameter(ParameterSetName = 'path')]
        [switch]
        $NoAutoCheckout,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [Parameter(ParameterSetName = 'id')]
        [Parameter(ParameterSetName = 'path')]
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $Comment,

        # Check in the secret if it is checked out
        [Parameter(ParameterSetName = 'id')]
        [Parameter(ParameterSetName = 'path')]
        [Parameter(ParameterSetName = 'restricted')]
        [switch]
        $ForceCheckIn,

        # Associated ticket number (required for ticket integrations)
        [Parameter(ParameterSetName = 'id')]
        [Parameter(ParameterSetName = 'path')]
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $TicketNumber,

        # Associated ticket system ID (required for ticket integrations)
        [Parameter(ParameterSetName = 'id')]
        [Parameter(ParameterSetName = 'path')]
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketSystemId,

        [Parameter(Mandatory, ParameterSetName = 'outfile')]
        [string]
        $OutFile
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession

        $restrictedParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'restricted'
        $restrictedParams = @()
        foreach ($r in $restrictedParamSet) {
            if ($tssParams.ContainsKey($r)) {
                $restrictedParams += $r
            }
        }
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            if ($PSCmdlet.ParameterSetName -eq 'outfile' -and $Id.Count -gt 1) {
                Write-Error 'OutFile takes a single secret ID'
                return
            }
            foreach ($secret in $Id) {
                if ($PSCmdlet.ParameterSetName -eq 'outfile') {
                    $uri = $TssSession.ApiUrl, 'secrets', $secret, 'fields', $Slug -join '/'
                    $invokeParams.Uri = $uri
                    $invokeParams.Method = 'GET'
                    $outFilePath = $PSCmdlet.GetUnresolvedProviderPathFromPSPath($OutFile)
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        if ($apiResponse.IsSuccessful -and $apiResponse.StatusCode -eq 200) {
                            [IO.File]::WriteAllBytes($outFilePath, $apiResponse.RawBytes)
                            Get-ChildItem -LiteralPath $outFilePath
                        } else {
                            $null = . $ProcessResponse $apiResponse
                        }
                    } catch {
                        Write-Warning "Issue getting field [$Slug] on secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }
                    continue
                }
                $currentSecret = $null

                $getSecretParams = @{
                    TssSession     = $TssSession
                    Id             = $secret
                    NoAutoCheckout = $NoAutoCheckout
                }
                if ($restrictedParams.Count -gt 0) {
                    $getSecretParams.Add('Comment', $Comment)
                    $getSecretParams.Add('ForceCheckIn', $ForceCheckIn)
                    $getSecretParams.Add('TicketNumber', $TicketNumber)
                    $getSecretParams.Add('TicketSystemId', $TicketSystemId)
                }
                $currentSecret = Get-TssSecret @getSecretParams
                if ($currentSecret) {
                    $currentSecretFileItem = $currentSecret.Items.Where( { $_.Slug -eq $Slug })

                    if ($currentSecretFileItem.IsFile) {
                        $attachmentFilename = $currentSecretFileItem.Filename
                    } else {
                        Write-Warning "Secert [$secret] and slug [$slug] is not found to be a file field"
                        continue
                    }

                    if ($attachmentFilename) {
                        $fileAttachment = [IO.Path]::Combine($Path, $attachmentFilename)
                        $getSecretFieldParams = @{
                            TssSession = $TssSession
                            Id         = $secret
                            Slug       = $Slug
                            OutFile    = $fileAttachment
                        }
                        if ($restrictedParams.Count -gt 0) {
                            $getSecretFieldParams.Add('Comment', $Comment)
                            $getSecretFieldParams.Add('ForceCheckIn', $ForceCheckIn)
                            $getSecretFieldParams.Add('TicketNumber', $TicketNumber)
                            $getSecretFieldParams.Add('TicketSystemId', $TicketSystemId)
                        }
                        Write-Verbose "Secret Attachment file name: $fileAttachment"
                        Get-TssSecretField @getSecretFieldParams

                        if (Test-Path $fileAttachment) {
                            Write-Verbose "Secret [$secret] file [$attachmentFilename] successfully written to the path [$fileAttachment]"
                            Get-ChildItem $fileAttachment
                        }
                    }
                } else {
                    Write-Warning "Unable to find a filename for Secret [$secret] and slug [$slug]"
                    continue
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
