function Update-TssSecretRdpLauncherSetting {
    <#
    .SYNOPSIS
    Update RDP Launcher Settings of a Secret for the current user.

    .DESCRIPTION
    Update RDP Launcher Settings of a Secret for the current user. The context of these settings are user-based only and is not global.

    .EXAMPLE
    session = New-TssSession -SecretServer https://alpha -Credential ssCred
    Update-TssSecretSetting -TssSession $session -Primary Parameter

    Update ...

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/Update-TssSecretRdpLauncherSetting

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/secrets/Update-TssSecretRdpLauncherSetting.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [cmdletbinding(SupportsShouldProcess)]
    [OutputType('Thycotic.PowerShell.Secrets.RdpLauncherSettings')]
    param(
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # SecretSetting ID
        [Parameter(Mandatory, ValueFromPipelineByPropertyName)]
        [Alias('SecretId')]
        [int[]]
        $Id,

        # Update Connect to Console
        [Parameter(ParameterSetName = 'allows')]
        [switch]
        $ConnectToConsole,

        # Update Allow Access to Printers
        [Parameter(ParameterSetName = 'allows')]
        [switch]
        $AllowPrinters,

        # Update Allow Access to Drives
        [Parameter(ParameterSetName = 'allows')]
        [switch]
        $AllowDrives,

        # Update Allow Access to Clipboard
        [Parameter(ParameterSetName = 'allows')]
        [switch]
        $AllowClipboard,

        # Update Allow Access to Smart Cards
        [Parameter(ParameterSetName = 'allows')]
        [switch]
        $AllowSmartCards,

        # Use Custom Window Size, Window Height
        [Parameter(Mandatory, ParameterSetName = 'resolution')]
        [int]
        $LauncherHeight,

        # Use Custom Window Size, Window Width
        [Parameter(Mandatory,ParameterSetName = 'resolution')]
        [int]
        $LauncherWidth
    )
    begin {
        $updateLaunchParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }
    process {
        Write-TssInternalNote $PSCmdlet.MyInvocation
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($updateLaunchParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000000' $PSCmdlet.MyInvocation
            foreach ($secret in $Id) {
                $restResponse = $null
                $uri = $TssSession.ApiUrl.Replace('api/v1', 'internals'), 'secret-detail', $secret, 'rdp-launcher-settings' -join '/'
                $invokeParams.Uri = $uri
                $invokeParams.Method = 'PUT'

                $updateLaunchBody = @{ data = @{ } }
                switch ($updateLaunchParams.Keys) {
                    'ConnectToConsole' {
                        $console = @{
                            dirty = $true
                            value = [boolean]$ConnectToConsole
                        }
                        $updateLaunchBody.data.Add('connectToConsole',$console)
                    }
                    'AllowPrinters' {
                        $printers = @{
                            dirty = $true
                            value = [boolean]$AllowPrinters
                        }
                        $updateLaunchBody.data.Add('allowPrinters',$printers)
                    }
                    'AllowDrives' {
                        $drives = @{
                            dirty = $true
                            value = [boolean]$AllowDrives
                        }
                        $updateLaunchBody.data.Add('allowDrives',$drives)
                    }
                    'AllowClipboard' {
                        $clipboard = @{
                            dirty = $true
                            value = [boolean]$AllowClipboard
                        }
                        $updateLaunchBody.data.Add('allowClipboard',$clipboard)
                    }
                    'AllowSmartCards' {
                        $smartCards = @{
                            dirty = $true
                            value = [boolean]$AllowSmartCards
                        }
                        $updateLaunchBody.data.Add('allowSmartCards',$smartCards)
                    }
                    'LauncherHeight' {
                        $resolutionH = @{
                            dirty = $true
                            value = $LauncherHeight
                        }
                        $updateLaunchBody.data.Add('launcherHeight',$resolutionH)

                        # both height and width are required params
                        $customResolution = @{
                            dirty = $true
                            value = [boolean]$UseCustomResolution
                        }
                        $updateLaunchBody.data.Add('useCustomLauncherResolution',$customResolution)
                    }
                    'LauncherWidth' {
                        $resolutionW = @{
                            dirty = $true
                            value = $LauncherWidth
                        }
                        $updateLaunchBody.data.Add('launcherWidth',$resolutionW)
                    }
                }
                $invokeParams.Body = $updateLaunchBody | ConvertTo-Json
                if ($PSCmdlet.ShouldProcess("description: $Primary Parameter", "$($invokeParams.Method) $uri with: `n$($invokeParams.Body)")) {
                    Write-Verbose "Performing the operation $($invokeParams.Method) $uri with: `n$($invokeParams.Body)"
                    try {
                        $apiResponse = Invoke-TssApi @invokeParams
                        $restResponse = . $ProcessApiResponse $apiResponse
                    } catch {
                        Write-Warning 'Issue updating Secret Launcher Settings for [$secret]'
                        $err = $_
                        . $ErrorHandling $err
                    }

                    if ($restResponse) {
                        [Thycotic.PowerShell.Secrets.RdpLauncherSettings]@{
                            AllowClipboard =$restResponse.allowClipboard.value
                            AllowDrives =$restResponse.allowDrives.value
                            AllowPrinters =$restResponse.allowPrinters.value
                            AllowSmartCards =$restResponse.allowSmartCards.value
                            ConnectToConsole =$restResponse.connectToConsole.value
                            LauncherHeight =$restResponse.launcherHeight.value
                            LauncherWidth =$restResponse.launcherWidth.value
                            UseCustomLauncherResolution =$restResponse.useCustomLauncherResolution.value
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}