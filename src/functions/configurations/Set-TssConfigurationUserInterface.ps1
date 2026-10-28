function Set-TssConfigurationUserInterface {
    <#
    .SYNOPSIS
    Set the user interface configuration

    .DESCRIPTION
    Updates the user interface configuration (custom logos and the global banner) and returns the updated configuration.
    Only the parameters you pass are sent; everything else keeps its current value. Switch parameters send their value, so -Name:$false turns a setting off.

    .PARAMETER TssSession
    TssSession object created by New-TssSession for authentication

    .PARAMETER CustomBannerEndDate
    When the global banner stops showing

    .PARAMETER CustomBannerStartDate
    When the global banner starts showing

    .PARAMETER CustomBannerStyle
    Banner style: status, failure, information, success, caution, warning or error

    .PARAMETER CustomBannerText
    Banner text

    .PARAMETER CustomBannerViewLink
    URL of the banner View link

    .PARAMETER CustomBannerViewLinkText
    Text of the banner View link

    .PARAMETER CustomLogoCollapsed
    Custom logo (light mode, collapsed nav)

    .PARAMETER CustomLogoCollapsedDark
    Custom logo (dark mode, collapsed nav)

    .PARAMETER CustomLogoFullSize
    Custom logo (light mode, full size)

    .PARAMETER CustomLogoFullSizeDark
    Custom logo (dark mode, full size)

    .PARAMETER CustomLogoLogin
    Custom logo on login screen (light mode)

    .PARAMETER CustomLogoLoginDark
    Custom logo on login screen (dark mode)

    .PARAMETER IsCustomBannerDismissable
    Users can dismiss the banner

    .PARAMETER ShowCustomBanner
    Show the global banner

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationUserInterface -TssSession $session -ShowCustomBanner -CustomBannerText 'Maintenance Saturday 22:00 UTC' -CustomBannerStyle 'warning' -CustomBannerEndDate (Get-Date).AddDays(3)

    Show a warning banner for the next three days

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Set-TssConfigurationUserInterface -TssSession $session -ShowCustomBanner:$false

    Hide the global banner

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Set-TssConfigurationUserInterface

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Set-TssConfigurationUserInterface.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Configuration.ConfigurationUserInterface')]
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        [datetime]
        $CustomBannerEndDate,

        [datetime]
        $CustomBannerStartDate,

        [string]
        $CustomBannerStyle,

        [string]
        $CustomBannerText,

        [string]
        $CustomBannerViewLink,

        [string]
        $CustomBannerViewLinkText,

        [string]
        $CustomLogoCollapsed,

        [string]
        $CustomLogoCollapsedDark,

        [string]
        $CustomLogoFullSize,

        [string]
        $CustomLogoFullSizeDark,

        [string]
        $CustomLogoLogin,

        [string]
        $CustomLogoLoginDark,

        [switch]
        $IsCustomBannerDismissable,

        [switch]
        $ShowCustomBanner
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            $uri = ($TssSession.ApiUrl -replace '/api/v1$','/api/v2'), 'configuration', 'user-interface' -join '/'
            $invokeParams.Uri = $uri
            $invokeParams.Method = 'PATCH'
            $body = @{ data = @{ } }
            switch ($tssParams.Keys) {
                'CustomBannerEndDate' {
                    $body.data.Add('customBannerEndDate', @{ dirty = $true; value = $CustomBannerEndDate })
                }
                'CustomBannerStartDate' {
                    $body.data.Add('customBannerStartDate', @{ dirty = $true; value = $CustomBannerStartDate })
                }
                'CustomBannerStyle' {
                    $body.data.Add('customBannerStyle', @{ dirty = $true; value = $CustomBannerStyle })
                }
                'CustomBannerText' {
                    $body.data.Add('customBannerText', @{ dirty = $true; value = $CustomBannerText })
                }
                'CustomBannerViewLink' {
                    $body.data.Add('customBannerViewLink', @{ dirty = $true; value = $CustomBannerViewLink })
                }
                'CustomBannerViewLinkText' {
                    $body.data.Add('customBannerViewLinkText', @{ dirty = $true; value = $CustomBannerViewLinkText })
                }
                'CustomLogoCollapsed' {
                    $body.data.Add('customLogoCollapsed', @{ dirty = $true; value = $CustomLogoCollapsed })
                }
                'CustomLogoCollapsedDark' {
                    $body.data.Add('customLogoCollapsedDark', @{ dirty = $true; value = $CustomLogoCollapsedDark })
                }
                'CustomLogoFullSize' {
                    $body.data.Add('customLogoFullSize', @{ dirty = $true; value = $CustomLogoFullSize })
                }
                'CustomLogoFullSizeDark' {
                    $body.data.Add('customLogoFullSizeDark', @{ dirty = $true; value = $CustomLogoFullSizeDark })
                }
                'CustomLogoLogin' {
                    $body.data.Add('customLogoLogin', @{ dirty = $true; value = $CustomLogoLogin })
                }
                'CustomLogoLoginDark' {
                    $body.data.Add('customLogoLoginDark', @{ dirty = $true; value = $CustomLogoLoginDark })
                }
                'IsCustomBannerDismissable' {
                    $body.data.Add('isCustomBannerDismissable', @{ dirty = $true; value = [boolean]$IsCustomBannerDismissable })
                }
                'ShowCustomBanner' {
                    $body.data.Add('showCustomBanner', @{ dirty = $true; value = [boolean]$ShowCustomBanner })
                }
            }
            $invokeParams.Body = $body | ConvertTo-Json -Depth 100
            if ($PSCmdlet.ShouldProcess("Configuration user interface", "$($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n")) {
                Write-Verbose "Performing the operation $($invokeParams.Method) $uri with:`n$($invokeParams.Body)`n"
                try {
                    $apiResponse = Invoke-TssApi @invokeParams
                    $restResponse = . $ProcessResponse $apiResponse
                } catch {
                    Write-Warning 'Issue with Set-TssConfigurationUserInterface request'
                    $err = $_
                    . $ErrorHandling $err
                }
                if ($restResponse) {
                    [Thycotic.PowerShell.Configuration.ConfigurationUserInterface](. $FilterTssResponse $restResponse ([Thycotic.PowerShell.Configuration.ConfigurationUserInterface]))
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}
