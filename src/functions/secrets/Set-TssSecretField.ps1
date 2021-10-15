function Set-TssSecretField {
    <#
    .SYNOPSIS
    Set value for a Secret Field

    .DESCRIPTION
    Set value for a Secret Field

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretField -TssSession $session -Id 42 -Slug notes -Value "Test test test"

    Set Notes field on Secret 42 to the value "Test test test"

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretField -TssSession $session -Id 93 -Slug Machine -Value "server2"

    Sets secret 93's field, "Machine", to "server2"

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretField -TssSession $session -Id 1455 -Slug Notes -Value "to be decommissioned" -Comment "updating notes field"

    Sets secret 1455's field, "Notes", to the provided value providing required comment

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretField -TssSession $session -Id 113 -Slug Notes -Clear

    Sets secret 1455's field, "Notes", to an empty value

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretField -TssSession $session -Id 42 -Slug attached-file -Path c:\files\attachment.txt

    Sets the attached-file field on Secret 42 to the attachment.txt (uploads the file to Secret Server)

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    $content = Get-Content c:\files\attachment.txt
    Set-TssSecretField -TssSession $session -Id 42 -Slug attached-file -Value $content -Filename 'attachment.txt'

    Sets the attached-file field on Secret 42 to the contents of the attachment.txt file, providing the appropriate filename desired

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/secrets/Set-TssSecretField

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Set-TssSecretField.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = 'reg')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Folder Id to modify
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # Field name (slug) of the secret
        [Parameter(Mandatory)]
        [Alias('Field')]
        [string]
        $Slug,

        # Value to set for the provided field
        [Parameter(ParameterSetName = 'reg')]
        [Parameter(ParameterSetName = 'raw')]
        $Value,

        # Clear/blank out the field value
        [Parameter(ParameterSetName = 'reg')]
        [switch]
        $Clear,

        # Filename to assign file contents provided from Value param to the field
        [Parameter(ParameterSetName = 'raw')]
        [string]
        $Filename,

        # Path of file to attach to field
        [Parameter(ParameterSetName = 'io')]
        [ValidateScript( {
                if (-not (Test-Path $_ -PathType Leaf)) { throw "Path [$_] is a directory, provide full file path" }
                return $true
            })]
        $Path,

        # Comment to provide for restricted secret (Require Comment is enabled)
        [Parameter(ParameterSetName = 'restricted')]
        [string]
        $Comment,

        # Force check-in of the Secret
        [Parameter(ParameterSetName = 'restricted')]
        [switch]
        $ForceCheckIn,

        # Associated Ticket Number
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketNumber,

        # Associated Ticket System ID
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketSystemId
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession

        $restrictedParamSet = . $ParameterSetParams $PSCmdlet.MyInvocation.MyCommand.Name 'restricted'
        $restrictedParams = @()
        foreach ($r in $restrictedParamSet) {
            if ($setParams.ContainsKey($r)) {
                $restrictedParams += $r
            }
        }
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation

            foreach ($secret in $Id) {
                $fieldBody = @{}
                if ($setParams.ContainsKey('Clear')) {
                    $fieldBody.Add('value', '')
                }
                if ($setParams.ContainsKey('Value') -and -not $setParams.ContainsKey('Filename')) {
                    $fieldBody.Add('value', $Value)
                }

                if ($setParams.ContainsKey('Path')) {
                    $pathFilename = Split-Path $Path -Leaf
                    $fieldBody.Add('fileName', $pathFilename)

                    $fileBinary = [IO.File]::ReadAllBytes($Path)
                    $fieldBody.Add('fileAttachment', $fileBinary)
                }

                if ($setParams.ContainsKey('Filename') -and $setParams.ContainsKey('Value')) {
                    $fieldBody.Add('fileName', $Filename)

                    if ($Value -is [System.String]) {
                        $fileBinary = [System.Text.Encoding]::UTF8.GetBytes($Value)
                        $fieldBody.Add('fileAttachment', $fileBinary)
                    } else {
                        $fieldBody.Add('fileAttachment', $Value)
                    }
                }

                if ($restrictedParams.Count -gt 0) {
                    switch ($setParams.Keys) {
                        'Comment' { $fieldBody.Add('comment', $Comment) }
                        'ForceCheckIn' { $fieldBody.Add('forceCheckIn', [boolean]$ForceCheckIn) }
                        'TicketNumber' { $fieldBody.Add('ticketNumber', $TicketNumber) }
                        'TicketSystemId' { $fieldBody.Add('ticketSystemId', $TicketSystemId) }
                    }
                }

                $uri = $TssSession.ApiUrl, 'secrets', $secret, 'fields', $Slug -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'
                $invokeParams.Body = $fieldBody | ConvertTo-Json -Depth 5

                if ($PSCmdlet.ShouldProcess("SecretId: $secret", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $fieldResponse = . $ProcessResponse $apiResponse
                    } catch {
                        Write-Warning "Issue setting field [$Slug] on secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($fieldResponse -eq $Value) {
                        Write-Verbose "Secret [$secret] field $Slug updated successfully"
                    } elseif ($setParams.ContainsKey('Clear') -and ($null -eq $fieldResponse)) {
                        Write-Verbose "Secret [$secret] field $Slug cleared successfully"
                    } else {
                        Write-Verbose "Response for secret [$secret]: $fieldResponse"
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}