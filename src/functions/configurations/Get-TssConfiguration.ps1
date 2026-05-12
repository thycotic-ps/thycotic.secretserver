function Get-TssConfiguration {
    <#
    .SYNOPSIS
    Get Secret Server configuration section(s)

    .DESCRIPTION
    Get Secret Server configuration section(s) found under Admin > Configuration

    .EXAMPLE
    $session = New-TssSession -SecretServer https://alpha -Credential $ssCred
    Get-TssConfiguration -TssSession $session -All

    Return all configuration objects

    .LINK
    https://thycotic-ps.github.io/thycotic.secretserver/commands/configurations/Get-TssConfiguration

    .LINK
    https://github.com/thycotic-ps/thycotic.secretserver/blob/main/src/functions/configurations/Get-TssConfiguration.ps1

    .NOTES
    Requires TssSession object returned by New-TssSession
    #>
    [CmdletBinding()]
    [OutputType('Thycotic.PowerShell.Configuration.General')]
    param (
        # TssSession object created by New-TssSession for authentication
        [Parameter(Mandatory, ValueFromPipeline, Position = 0)]
        [Thycotic.PowerShell.Authentication.Session]
        $TssSession,

        # Configuration type (Application, Email, Folders, Launcher, LocalUserPasswords, PermissionOptions, UserExperience, UserInterface)
        [ValidateSet('All', 'Application', 'Email', 'Folders', 'Launcher', 'LocalUserPasswords', 'PermissionOptions', 'UserExperience', 'UserInterface')]
        [string]
        $Type = 'All'
    )
    begin {
        $tssParams = $PSBoundParameters
        $invokeParams = . $GetInvokeApiParams $TssSession
    }

    process {
        Get-TssInvocation $PSCmdlet.MyInvocation
        if ($tssParams.ContainsKey('TssSession') -and $TssSession.IsValidSession()) {
            Compare-TssVersion $TssSession '10.9.000032' $PSCmdlet.MyInvocation
            $uri = $TssSession.ApiUrl, 'configuration', 'general' -join '/'

            $uriParams = @()
            if ($Type -eq 'All') {
                $params = 'loadAll=true'
            } else {
                switch ($Type) {
                    'Application' { $uriParams += 'loadApplicationSettings=true' }
                    'Email' { $uriParams += 'loadEmail=true' }
                    'Folders' { $uriParams += 'loadFolders=true' }
                    'Launcher' { $uriParams += 'loadLauncherSettings=true' }
                    'LocalUserPasswords' { $uriParams += 'loadLocalUserPasswords=true' }
                    'PermissionOptions' { $uriParams += 'loadPermissionOptions=true' }
                    'UserExperience' { $uriParams += 'loadUserExperience=true' }
                    'UserInterface' { $uriParams += 'loadUserInterface=true' }
                }
                $params = $uriParams -join '&'
            }
            $invokeParams.Uri = $uri, $params -join '?'
            $invokeParams.Method = 'GET'

            Write-Verbose "Performing the operation $($invokeParams.Method) $($invokeParams.Uri)"
            try {
                $apiResponse = Invoke-TssApi @invokeParams
                $restResponse = . $ProcessResponse $apiResponse
            } catch {
                Write-Warning "Issue getting configuration for [$($TssSession.SecretServer)]"
                $err = $_
                . $ErrorHandling $err
            }

            if ($restResponse) {
                # SS 12.0 renamed 'emailSettings' to 'email' on the v1 configuration/general response; accept either.
                $emailRaw = if ($null -ne $restResponse.email) { $restResponse.email } else { $restResponse.emailSettings }

                switch ($Type) {
                    'All' {
                        # Pre-filter each nested sub-object before assignment so unknown SS 12.0 fields
                        # (e.g. EmailSettings.sendEmailMethod) don't break the outer [General] cast.
                        $general = [Thycotic.PowerShell.Configuration.General]::new()
                        if ($null -ne $restResponse.applicationSettings) {
                            $general.ApplicationSettings = [Thycotic.PowerShell.Configuration.ApplicationSettings](. $FilterTssResponse $restResponse.applicationSettings ([Thycotic.PowerShell.Configuration.ApplicationSettings]))
                        }
                        if ($null -ne $emailRaw) {
                            $general.Email = [Thycotic.PowerShell.Configuration.EmailSettings](. $FilterTssResponse $emailRaw ([Thycotic.PowerShell.Configuration.EmailSettings]))
                        }
                        if ($null -ne $restResponse.folders) {
                            $general.Folders = [Thycotic.PowerShell.Configuration.Folders](. $FilterTssResponse $restResponse.folders ([Thycotic.PowerShell.Configuration.Folders]))
                        }
                        if ($null -ne $restResponse.launcherSettings) {
                            $general.LauncherSettings = [Thycotic.PowerShell.Configuration.LauncherSettings](. $FilterTssResponse $restResponse.launcherSettings ([Thycotic.PowerShell.Configuration.LauncherSettings]))
                        }
                        if ($null -ne $restResponse.localUserPasswords) {
                            $general.LocalUserPasswords = [Thycotic.PowerShell.Configuration.LocalUserPasswords](. $FilterTssResponse $restResponse.localUserPasswords ([Thycotic.PowerShell.Configuration.LocalUserPasswords]))
                        }
                        if ($null -ne $restResponse.permissionOptions) {
                            $general.PermissionOptions = [Thycotic.PowerShell.Configuration.PermissionOptions](. $FilterTssResponse $restResponse.permissionOptions ([Thycotic.PowerShell.Configuration.PermissionOptions]))
                        }
                        if ($null -ne $restResponse.protocolHandlerSettings) {
                            $general.ProtocolHandlerSettings = [Thycotic.PowerShell.Configuration.ProtocolHandlerSettings](. $FilterTssResponse $restResponse.protocolHandlerSettings ([Thycotic.PowerShell.Configuration.ProtocolHandlerSettings]))
                        }
                        if ($null -ne $restResponse.userExperience) {
                            $general.UserExperience = [Thycotic.PowerShell.Configuration.UserExperience](. $FilterTssResponse $restResponse.userExperience ([Thycotic.PowerShell.Configuration.UserExperience]))
                        }
                        if ($null -ne $restResponse.userInterface) {
                            $general.UserInterface = [Thycotic.PowerShell.Configuration.UserInterface](. $FilterTssResponse $restResponse.userInterface ([Thycotic.PowerShell.Configuration.UserInterface]))
                        }
                        if ($null -ne $restResponse.sessionRecording) {
                            $general.sessionRecording = [Thycotic.PowerShell.Configuration.SessionRecording](. $FilterTssResponse $restResponse.sessionRecording ([Thycotic.PowerShell.Configuration.SessionRecording]))
                        }
                        if ($null -ne $restResponse.unlimitedAdmin) {
                            $general.unlimitedAdmin = [Thycotic.PowerShell.Configuration.UnlimitedAdmin](. $FilterTssResponse $restResponse.unlimitedAdmin ([Thycotic.PowerShell.Configuration.UnlimitedAdmin]))
                        }
                        $general
                    }
                    'Application' {
                        if ($null -ne $restResponse.applicationSettings) {
                            [Thycotic.PowerShell.Configuration.ApplicationSettings](. $FilterTssResponse $restResponse.applicationSettings ([Thycotic.PowerShell.Configuration.ApplicationSettings]))
                        }
                    }
                    'Email' {
                        if ($null -ne $emailRaw) {
                            [Thycotic.PowerShell.Configuration.EmailSettings](. $FilterTssResponse $emailRaw ([Thycotic.PowerShell.Configuration.EmailSettings]))
                        }
                    }
                    'Folders' {
                        if ($null -ne $restResponse.folders) {
                            [Thycotic.PowerShell.Configuration.Folders](. $FilterTssResponse $restResponse.folders ([Thycotic.PowerShell.Configuration.Folders]))
                        }
                    }
                    'Launcher' {
                        if ($null -ne $restResponse.launcherSettings) {
                            [Thycotic.PowerShell.Configuration.LauncherSettings](. $FilterTssResponse $restResponse.launcherSettings ([Thycotic.PowerShell.Configuration.LauncherSettings]))
                        }
                    }
                    'LocalUserPasswords' {
                        if ($null -ne $restResponse.localUserPasswords) {
                            [Thycotic.PowerShell.Configuration.LocalUserPasswords](. $FilterTssResponse $restResponse.localUserPasswords ([Thycotic.PowerShell.Configuration.LocalUserPasswords]))
                        }
                    }
                    'PermissionOptions' {
                        if ($null -ne $restResponse.permissionOptions) {
                            [Thycotic.PowerShell.Configuration.PermissionOptions](. $FilterTssResponse $restResponse.permissionOptions ([Thycotic.PowerShell.Configuration.PermissionOptions]))
                        }
                    }
                    'UserExperience' {
                        if ($null -ne $restResponse.userExperience) {
                            [Thycotic.PowerShell.Configuration.UserExperience](. $FilterTssResponse $restResponse.userExperience ([Thycotic.PowerShell.Configuration.UserExperience]))
                        }
                    }
                    'UserInterface' {
                        if ($null -ne $restResponse.userInterface) {
                            [Thycotic.PowerShell.Configuration.UserInterface](. $FilterTssResponse $restResponse.userInterface ([Thycotic.PowerShell.Configuration.UserInterface]))
                        }
                    }
                }
            }
        } else {
            Write-Warning 'No valid session found'
        }
    }
}