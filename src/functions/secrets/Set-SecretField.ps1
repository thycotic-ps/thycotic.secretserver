function Set-SecretField {
    <#
    .SYNOPSIS
    Set value for a Secret Field

    .DESCRIPTION
    Set value for a Secret Field

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssSecretField -TssSession $session Id 42 -Slug notes -Value "Test test test"

    Set Notes field on Secret 42 to the value "Test test test"

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Set-TssSecretField

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess, DefaultParameterSetName = 'all')]
    param(
        # TssSession object created by New-TssSession for auth
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [TssSession]
        $TssSession,

        # Folder Id to modify
        [Parameter(Mandatory,ValueFromPipelineByPropertyName)]
        [Alias("SecretId")]
        [int[]]
        $Id,

        # Field name (slug) of the secret
        [Parameter(Mandatory)]
        [Alias('Field')]
        [string]
        $Slug,

        # Value to set for the provided field
        [string]
        $Value,

        # Clear/blank out the field value
        [switch]
        $Clear,

        # Path of file to attach
        [ValidateScript({
            if (Test-Path $_ -PathType Container) {
                throw "Path [$_] is a directory, provide full file path"
            } else {
                $true
            }
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

        #Associated Ticket System ID
        [Parameter(ParameterSetName = 'restricted')]
        [int]
        $TicketSystemId
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeTssParams $TssSession
    }
    process {
        Write-Verbose "Provided command parameters: $(. $GetInvocation $PSCmdlet.MyInvocation)"
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            . $CheckVersion $TssSession '10.9.0000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                if ($setParams.ContainsKey('Clear') -and $setParams.ContainsKey('Value')) {
                    Write-Warning "Clear and Value provided, only one is supported"
                    return
                }

                $fieldBody = @{}
                if ($setParams.ContainsKey('Clear')) {
                    $fieldBody.Add('value',"")
                }
                if ($setParams.ContainsKey('Value')) {
                    $fieldBody.Add('value',$Value)
                }

                if ($setParams.ContainsKey('Path')) {
                    $fileName = Split-Path $Path -Leaf
                    $fieldBody.Add('fileName',$fileName)

                    $fileBinary = [IO.File]::ReadAllBytes($Path)
                    $fieldBody.Add('fileAttachment',$fileBinary)
                }

                if ($restrictedParams.Count -gt 0) {
                    switch ($restrictedParams) {
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
                    Write-Verbose "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                    try {
                        $fieldResponse = Invoke-TssRestApi @invokeParams
                    } catch {
                        Write-Warning "Issue setting field $Field on secret [$secret]"
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($fieldResponse -eq $Value) {
                        Write-Verbose "Secret [$secret] field $Field updated successfully"
                    } elseif ($setParams.ContainsKey('Clear') -and ($null -eq $fieldResponse)) {
                        Write-Verbose "Secret [$secret] field $Field cleared successfully"
                    } else {
                        Write-Verbose "Response for secret [$secret]: $fieldResponse"
                    }
                }
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}