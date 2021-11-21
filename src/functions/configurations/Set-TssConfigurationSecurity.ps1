function Set-TssConfigurationSecurity {
    <#
    .SYNOPSIS
    Set Security Configuration

    .DESCRIPTION
    Set Security Configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationSecurity -TssSession $session -ForceHttps

    Enable Force HTTPS

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationSecurity -TssSession $session -ForceHttps:$false

    Disabling Force HTTPS

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationSecurity

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationSecurity.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory,ValueFromPipeline,Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Apply TLS Certificate Chain Policy and Error Auditing
        [switch]
        $AuditTlsErrors,

        # Enable TLS Debugging and connection tracking
        [switch]
        $AuditTlsErrorsDebug,

        # Certificate chain policy options
        [string]
        $CertificatePolicyOption,

        # Client Certificate ID
        [string]
        $CertificateId,

        # Enable file restrictions
        [switch]
        $FileRestriction,

        # File extensions to restrict
        [string]
        $FileExtension,

        # Max file size in bytes
        [string]
        $FileMaxSize,

        # Max allowed by ASP.NET
        [switch]
        $FileMaxSizeSupported,

        # Enable frame blocking
        [switch]
        $FrameBlocking,

        # Enable FIPS compliance
        [switch]
        $Fips,

        # Enable Force HTTPS
        [switch]
        $ForceHttps,

        # Hide Version number
        [switch]
        $HideVersion,

        # Web Password Filler (WPF) requires full domain match
        [switch]
        $WpfRequireDomainMatch
    )
    begin {
        $setParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($setParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000064' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'security' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'

            $setBody = @{ data = @{ } }
            switch ($setParams.Keys) {
                'AuditTlsErrors' {
                    $auditTls = @{
                        dirty = $true
                        value = [boolean]$AuditTls
                    }
                    $setBody.data.Add('auditTlsErrors',$auditTls)
                }
                'AuditTlsErrorsDebug' {
                    $auditTlsErrorDebug = @{
                        dirty = $true
                        value = [boolean]$AuditTlsErrorsDebug
                    }
                    $setBody.data.Add('auditTlsErrorsDebug',$auditTlsErrorDebug)
                }
                'CertificatePolicyOption' {
                    $certOption = @{
                        dirty = $true
                        value = $CertificatePolicyOption
                    }
                    $setBody.data.Add('certificateChainPolicyOptions',$certOption)
                }
                'CertificateId' {
                    $certId = @{
                        dirty = $true
                        value = $CertificateId
                    }
                    $setBody.data.Add('clientCertificateIds',$certId)
                }
                'FileRestriction' {
                    $fileRestrict = @{
                        dirty = $true
                        value = [boolean]$FileRestriction
                    }
                    $setBody.data.Add('enableFileRestrictions',$fileRestrict)
                    if ($setParams.ContainsKey('FileExtension')) {
                        $fileExt = @{
                            dirty = $true
                            value = $FileExtension
                        }
                        $setBody.data.Add('fileExtensionRestrictions',$fileExt)
                    }
                }
                'FileMaxSize' {
                    $maxFile = @{
                        dirty = $true
                        value = $FileMaxSize
                    }
                    $setBody.data.Add('maximumFileSizeBytes',$maxFile)
                }
                'FileMaxSizeSupported' {
                    $maxSupported = @{
                        dirty = $true
                        value = [boolean]$FileMaxSizeSupported
                    }
                    $setBody.data.Add('maximumFileSizeSupported',$maxSupported)
                }
                'Fips' {
                    $enableFips = @{
                        dirty = $true
                        value = [boolean]$Fips
                    }
                    $setBody.data.Add('fipsEnabled',$enableFips)
                }
                'ForceHttps' {
                    $httpsEnforce = @{
                        dirty = $true
                        value = [boolean]$ForceHttps
                    }
                    $setBody.data.Add('forceHttps',$httpsEnforce)
                }
                'HideVersion' {
                    $hideVer = @{
                        dirty = $true
                        value = [boolean]$HideVersion
                    }
                    $setBody.data.Add('hideVersionNumber',$hideVer)
                }
                'WpfRequireDomainMatch' {
                    $wpfDomain = @{
                        dirty = $true
                        value = [boolean]$WpfRequireDomainMatch
                    }
                    $setBody.data.Add('webPasswordFillerRequiresFullDomainMatch',$wpfDomain)
                }
            }

            $invokeParams.Body = $setBody | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Security Configuration", "$($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri) with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning "Issue setting configuration"
                    $err = $_
                    . $ErrorHandling $err
                }
            }
            if ($restResponse) {
                Write-Verbose "Setting updated successfully"
            }
        } else {
            Write-Warning "No valid session found"
        }
    }
}