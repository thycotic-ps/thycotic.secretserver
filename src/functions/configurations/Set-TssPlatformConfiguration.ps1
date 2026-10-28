function Set-TssPlatformConfiguration {
    <#
    .SYNOPSIS
    Set the Delinea Platform configuration

    .DESCRIPTION
    Set the Delinea Platform integration settings.
    Secret Server applies the synchronization intervals, audit and inventory forwarding, MFA and login page options only while OpenIdConnectEnabled is on; with it off they are ignored, and every update resets the login page options to false.
    ForcePlatformOnlyLogin turns off local login: make sure a Platform login works before you set it.
    The permission cache expiration, provisioning mode, UsePlatformSettings, vault Id and tenant Id that Get-TssPlatformConfiguration returns cannot be set here. While OpenIdConnectEnabled is off, every update clears the vault Id and tenant Id.
    Only the parameters you pass are sent. Returns the Delinea Platform configuration after the update.
    Changing the Platform configuration, unified mode or Platform user mappings can cause loss of access to the Delinea Platform.
    The command writes that warning and asks OK to proceed? before it sends the request. -Force skips the question, and the confirmation prompt unless -Confirm is passed, for unattended runs; -WhatIf shows the request without sending it.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER EnablePlatformAuditIntegration
    Send audit events to the Delinea Platform

    .PARAMETER EnablePlatformInventoryForwarding
    Send discovered computers to the Delinea Platform inventory

    .PARAMETER EnablePlatformOnLoginPage
    Show the Delinea Platform login option on the login page

    .PARAMETER ForcePlatformOnlyLogin
    Allow only Delinea Platform login; local login is turned off

    .PARAMETER OpenIdConnectClientId
    OpenID Connect client Id

    .PARAMETER OpenIdConnectClientSecret
    OpenID Connect client secret

    .PARAMETER OpenIdConnectEnabled
    Turn on OpenID Connect login through the Delinea Platform

    .PARAMETER OpenIdConnectLoginUrl
    OpenID Connect login URL

    .PARAMETER OpenIdConnectLogoutUrl
    OpenID Connect logout URL

    .PARAMETER PlatformTenantId
    Delinea Platform tenant Id (GUID). Used only to check the client Id and secret while OpenIdConnectEnabled is on; Secret Server does not save it

    .PARAMETER ProfileName
    Authentication profile name

    .PARAMETER RequirePlatformMfa
    Require multifactor authentication through the Delinea Platform

    .PARAMETER SynchronizationIntervalDays
    Days between Platform synchronizations

    .PARAMETER SynchronizationIntervalHours
    Hours between Platform synchronizations

    .PARAMETER Force
    Skip the OK to proceed? question, and the confirmation prompt unless -Confirm is passed. The warning is still written.

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssPlatformConfiguration -TssSession $session -SynchronizationIntervalHours 6

    Synchronize with the Delinea Platform every six hours (Platform integration on)

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssPlatformConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssPlatformConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess, ConfirmImpact = 'High')]
    [OutputType('Thycotic.PowerShell.Configuration.PlatformConfiguration')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [switch]
        $EnablePlatformAuditIntegration,

        [switch]
        $EnablePlatformInventoryForwarding,

        [switch]
        $EnablePlatformOnLoginPage,

        [switch]
        $ForcePlatformOnlyLogin,

        [string]
        $OpenIdConnectClientId,

        [securestring]
        $OpenIdConnectClientSecret,

        [switch]
        $OpenIdConnectEnabled,

        [string]
        $OpenIdConnectLoginUrl,

        [string]
        $OpenIdConnectLogoutUrl,

        [string]
        $PlatformTenantId,

        [string]
        $ProfileName,

        [switch]
        $RequirePlatformMfa,

        [int]
        $SynchronizationIntervalDays,

        [int]
        $SynchronizationIntervalHours,

        [switch]
        $Force
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'platform' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'EnablePlatformAuditIntegration' {
                    $body.data.Add('enablePlatformAuditIntegration', @{ dirty = $true; value = [boolean]$EnablePlatformAuditIntegration })
                }
                'EnablePlatformInventoryForwarding' {
                    $body.data.Add('enablePlatformInventoryForwarding', @{ dirty = $true; value = [boolean]$EnablePlatformInventoryForwarding })
                }
                'EnablePlatformOnLoginPage' {
                    $body.data.Add('enablePlatformOnLoginPage', @{ dirty = $true; value = [boolean]$EnablePlatformOnLoginPage })
                }
                'ForcePlatformOnlyLogin' {
                    $body.data.Add('forcePlatformOnlyLogin', @{ dirty = $true; value = [boolean]$ForcePlatformOnlyLogin })
                }
                'OpenIdConnectClientId' {
                    $body.data.Add('openIdConnectClientId', @{ dirty = $true; value = $OpenIdConnectClientId })
                }
                'OpenIdConnectClientSecret' {
                    $body.data.Add('openIdConnectClientSecret', @{ dirty = $true; value = [System.Net.NetworkCredential]::new('', $OpenIdConnectClientSecret).Password })
                }
                'OpenIdConnectEnabled' {
                    $body.data.Add('openIdConnectEnabled', @{ dirty = $true; value = [boolean]$OpenIdConnectEnabled })
                }
                'OpenIdConnectLoginUrl' {
                    $body.data.Add('openIdConnectLoginUrl', @{ dirty = $true; value = $OpenIdConnectLoginUrl })
                }
                'OpenIdConnectLogoutUrl' {
                    $body.data.Add('openIdConnectLogoutUrl', @{ dirty = $true; value = $OpenIdConnectLogoutUrl })
                }
                'PlatformTenantId' {
                    $body.data.Add('platformTenantId', @{ dirty = $true; value = $PlatformTenantId })
                }
                'ProfileName' {
                    $body.data.Add('profileName', @{ dirty = $true; value = $ProfileName })
                }
                'RequirePlatformMfa' {
                    $body.data.Add('requirePlatformMfa', @{ dirty = $true; value = [boolean]$RequirePlatformMfa })
                }
                'SynchronizationIntervalDays' {
                    $body.data.Add('synchronizationIntervalDays', @{ dirty = $true; value = $SynchronizationIntervalDays })
                }
                'SynchronizationIntervalHours' {
                    $body.data.Add('synchronizationIntervalHours', @{ dirty = $true; value = $SynchronizationIntervalHours })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if (Confirm-TssDangerousOperation $PSCmdlet PlatformAccess "Platform configuration" "$($invokeParams.Method) $uri (request body not shown: it carries sensitive values)" -Force:$Force) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri (request body not shown: it carries sensitive values)"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssPlatformConfiguration request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.PlatformConfiguration](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.PlatformConfiguration]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
