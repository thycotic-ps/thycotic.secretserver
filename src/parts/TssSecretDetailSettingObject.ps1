<#
    .Synopsis
        Creates a TssSecretDetailSettings object
#>
param(
    [pscustomobject]
    $Object
)

begin {
    $Properties = $Object[0].PSObject.Properties.Name
    if ($Object.rdpLauncherSettings) {
        $rdpLauncherProps = $Object.rdpLauncherSettings[0].PSObject.Properties.Name
    } else {
        Write-Verbose "No RdpLauncherSettings found on records object"
    }
    if ($Object.sshLauncherSettings) {
        $sshLauncherProps = $Object.sshLauncherSettings[0].PSObject.Properties.Name
    } else {
        Write-Verbose "No SshLauncherSettings found on records object"
    }
    if ($Object.oneTimePasswordSettings) {
        $oneTimeProps = $Object.oneTimePasswordSettings[0].PSObject.Properties.Name
    } else {
        Write-Verbose "No OneTimePasswordSettings found on records object"
    }
}

process {
    if ($rdpLauncherProps) {
        $rdpLauncherSettings = @()
        foreach ($rdp in $Object.rdpLauncherSettings) {
            $rpdChild = [TssRdpLauncherSettings]::new()
            foreach ($cProp in $rdpLauncherProps) {
                if ($cProp -in $rpdChild.PSObject.Properties.Name) {
                    $rpdChild.$cProp = $rdp.$cProp
                } else {
                    Write-Warning "Property $cProp does not exist in the TssRdpLauncherSettings class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                }
                $rdpLauncherSettings += $rpdChild
            }
        }
    }
    if ($sshLauncherProps) {
        $sshLauncherSettings = @()
        foreach ($ssh in $Object.sshLauncherSettings) {
            $sshChild = [TssSshLauncherSettings]::new()
            foreach ($cProp in $sshLauncherProps) {
                if ($cProp -in $sshChild.PSObject.Properties.Name) {
                    $sshChild.$cProp = $ssh.$cProp
                } else {
                    Write-Warning "Property $cProp does not exist in the TssSshLauncherSettings class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                }
                $sshLauncherSettings += $sshChild
            }
        }
    }
    if ($oneTimeProps) {
        $oneTimePasswordSettings = @()
        foreach ($one in $Object.oneTimePasswordSettings) {
            $oneChild = [TssOneTimePasswordSettings]::new()
            foreach ($cProp in $oneTimeProps) {
                if ($cProp -in $oneChild.PSObject.Properties.Name) {
                    if ($one.cProp) {
                        $oneChild.$cProp = $one.$cProp
                    }
                } else {
                    Write-Warning "Property $cProp does not exist in the TssOneTimePasswordSettings class. Please create a bug report at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
                }
                $oneTimePasswordSettings += $oneChild
            }
        }
    }

    $outObject = @()
    foreach ($p in $Object) {
        $currentObject = [TssSecretDetailSettings]::new()
        foreach ($pProp In $Properties) {
            if ($pProp -eq 'rdpLauncherSettings') {
                    $currentObject.RdpLauncherSettings = $rdpLauncherSettings
            }
            if ($pProp -eq 'sshLauncherSettings') {
                    $currentObject.SshLauncherSettings = $sshLauncherSettings
            }
            if ($pProp -eq 'oneTimePasswordSettings') {
                    $currentObject.OneTimePasswordSettings = $oneTimePasswordSettings
            }
            if ($pProp -in $currentObject.PSObject.Properties.Name) {
                if ($p.$pProp) {
                    $currentObject.$pProp = $p.$pProp
                }
            } else {
                Write-Warning "Property $pProp does not exist in the TssSecretDetailSettings at https://github.com/thycotic-ps/thycotic.secretserver/issues/new/choose"
            }
        }
        $outObject += $currentObject
    }
    return $outObject
}